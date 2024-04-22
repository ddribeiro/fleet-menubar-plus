//
//  MenuBarView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

enum HostError: Error {
    case noHostFound
}

struct MenuBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.networkManager) var networkManager

    let user: User = Bundle.main.decode(User.self, from: "user.json")
    let policies = [FleetPolicy]()

    let timer = Timer.publish(every: 300, tolerance: 60, on: .main, in: .common).autoconnect()

    @State var currentHost: Host?
    @State private var loadingState = LoadingState.loading
    @State private var date: Date?

//    @AppStorage("deviceID") var deviceID: Int?
    @State private var deviceID: Int?

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(colorScheme == .light ? "13" : "18")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)

                    Spacer()

                    Image(systemName: "arrow.clockwise")
                        .onTapGesture {
                            Task {
                                currentHost = try await getCurrentHost()
                            }
                        }
                    Image(systemName: "bell.badge.fill")
                    Menu {
                        Button("About") { }
                        Button("Refresh") {
                            Task {
                                currentHost = try await getCurrentHost()
                            }
                        }
                        Divider()
                        Button("Quit") {
                            NSApplication.shared.terminate(nil)
                        }.keyboardShortcut("q")
                    } label: {
                        Label("Menu", systemImage: "line.3.horizontal")
                            .labelStyle(.iconOnly)
                    }
                    .frame(width: 25, height: 20)
                    .menuStyle(.borderlessButton)
                }
                .padding()

                Divider()

                HStack {
                    UserPreviewView(user: user.user, host: currentHost)
                    Spacer()
                }

                Divider()

                HStack {
                    Text("Actions")
                        .font(.headline)

                    Spacer()
                }
                .padding(.horizontal)

                Grid(horizontalSpacing: 14, verticalSpacing: 12) {
                    GridRow {
                        RequestAppAccessCard()
                        ViewAppAccessCard(applications: user.user.assignedApps)
                        ViewGroupsCard()
                    }
                    .frame(width: 130, height: 100)
                    .background(.thickMaterial)
                }
                .containerShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .fixedSize(horizontal: false, vertical: true)

                Divider()
                Group {
                    HStack {
                        Text("My Device Health")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)

                    if (currentHost?.mdm?.encryptionKeyAvailable) == false {
                        EscrowKeyView()
                            .padding(.horizontal)
                    }
                    switch loadingState {
                    case .loading:
                        LoadingView()
                    case .loaded:
                        ScrollView {
                            if let currentHost = currentHost {
                                if let policies = currentHost.policies {
                                    ForEach(policies) { policy in
                                        NavigationLink(value: policy) {
                                            DevicePolicyRow(policy: policy)
                                        }
                                        .buttonStyle(.borderless)
                                        .tint(.primary)
                                    }
                                    .background(.thickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding(.horizontal)
                                }
                            } else {
                                LoadingView()
                            }
                        }
                        .frame(maxHeight: 300)
                    case .failed:
                        Text("There was an error loading your device stats")
                    }

                }
                Text("Last updated on \(date?.formatted(date: .abbreviated, time: .shortened) ?? "")")
                    .font(.footnote)
                    .foregroundColor(.secondary)

                    .padding()
            }
            .navigationDestination(for: FleetPolicy.self, destination: PolicyDetailView.init)
        }
        .background(.ultraThinMaterial)
        .frame(width: 450, height: 650)
        .onReceive(timer) { _ in
            Task {
                currentHost = try await getCurrentHost()
            }
        }
        .task {
            Task {
                currentHost = try await getCurrentHost()
            }
        }
    }

    // Gets the device serial number the app is running on.
    // To be used to identify which device should be used
    // to display info received from the Fleet API.
    // https://ourcodeworld.com/articles/read/1113/how-to-retrieve-the-serial-number-of-a-mac-with-swift
    func getDeviceSerialNumber() -> String {
        var serialNumber: String? {
            let platformExpert = IOServiceGetMatchingService(
                kIOMainPortDefault,
                IOServiceMatching("IOPlatformExpertDevice")
            )

            guard platformExpert > 0 else {
                return nil
            }

            guard let serialNumber = (
                IORegistryEntryCreateCFProperty(
                    platformExpert,
                    kIOPlatformSerialNumberKey as CFString,
                    kCFAllocatorDefault, 0).takeUnretainedValue() as? String)?
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            else {
                return nil
            }

            IOObjectRelease(platformExpert)

            return serialNumber
        }

        return serialNumber ?? "Unknown"
    }

    func getCurrentHost() async throws -> Host {
        do {
            loadingState = .loading

            var allHosts = [Host]()
            var currentHost: Host

            if deviceID == nil {
                // Get a list of all hosts from the Fleet API
                allHosts = try await networkManager.fetch(.hosts)

                deviceID = allHosts.first(where: { $0.hardwareSerial == getDeviceSerialNumber() })?.id
            }

            // Serach the returned list of hosts for a result that matches the current serial number
            if let id = deviceID {
                let endpoint = Endpoint.getHost(id: id)
                currentHost = try await networkManager.fetch(endpoint)

                date = Date.now

                loadingState = .loaded
            } else {
                loadingState = .failed
                throw HostError.noHostFound

            }

            return currentHost
        } catch {
            print("There was an error retrieving hosts: \(error)")
            throw error
        }
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView(currentHost: Host.example)
    }
}
