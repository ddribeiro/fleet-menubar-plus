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
    @State var currentHost: Host?
    @State private var loadingState = LoadingState.loading

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

                    Image(systemName: "bell.badge.fill")
                    Image(systemName: "line.3.horizontal")
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
                        HStack {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(.red)
                            Text("FileVault Encryption Key Not Escrowed")
                                .font(.headline)
                                .foregroundColor(.red)

                            Spacer()

                            Button {
                                Task {
                                    try await rotateEncryptionKey()
                                }
                            } label: {
                                Text("Escrow Key")
                            }
                            .buttonStyle(.automatic)
                        }
                        .padding(.horizontal)

                    }

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
                            VStack {
                                ProgressView()
                                Text("Loading Device Policies from Fleet")
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                        }
                    }
                    .frame(maxHeight: 300)
                }

                Text("Secure login and automated access provided by Harmonize.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .navigationDestination(for: FleetPolicy.self, destination: PolicyDetailView.init)
        }
        .background(.ultraThinMaterial)
        .frame(width: 450, height: 650)
        .task {
            do {
                currentHost = try await getCurrentHost()
            } catch {
                print("Failed to get current host")
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
            var allHosts = [Host]()
            var currentHost: Host

            // Get a list of all hosts from the Fleet API
            allHosts = try await networkManager.fetch(.hosts)

            // Serach the returned list of hosts for a result that matches the current serial number
            if let host = allHosts.first(where: { $0.hardwareSerial == getDeviceSerialNumber() }) {
                let endpoint = Endpoint.getHost(id: host.id)
                currentHost = try await networkManager.fetch(endpoint)

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

    func rotateEncryptionKey() async throws {

        guard let deviceToken = readTokenFromFile() else { return }

        guard let url = URL(
            string: "fleet/device/\(deviceToken)/rotate_encryption_key",
            relativeTo: networkManager.environment.baseURL
        ) else {
            throw URLError(.unsupportedURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        var (_, _) = try await networkManager.environment.session.data(for: request)
    }

    func readTokenFromFile() -> String? {
        let fileURL = URL(fileURLWithPath: "/opt/orbit/identifier")

        do {
            // Read the content of the file into a string
            let token = try String(contentsOf: fileURL, encoding: .utf8)
            return token.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            // Handle any errors that might occur during file reading
            print("Error reading file: \(error)")
            return nil
        }
    }

}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView(currentHost: Host.example)
    }
}
