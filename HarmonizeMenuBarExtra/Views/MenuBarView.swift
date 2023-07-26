//
//  MenuBarView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct MenuBarView: View {
    @Environment(\.colorScheme) var colorScheme
    let user: User = Bundle.main.decode(User.self, from: "user.json")

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
                    UserPreviewView(user: user.user)
                    Spacer()
                }

                Divider()

                HStack {
                    Text("Actions")
                        .font(.headline)

                    Spacer()
                }
                .padding(.horizontal)

                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    GridRow {
                        RequestAppAccessCard()
                        ViewAppAccessCard(applications: user.user.assignedApps)
                        ViewGroupsCard()
                    }
                    .frame(width: 120, height: 100)
                    .background(.regularMaterial)
                }
                .containerShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom)

                Divider()

                HStack {
                    Text("My Device Health")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)

                ScrollView {
                    ForEach(user.user.devices) { device in
                        ForEach(device.policies) { policy in
                            NavigationLink(value: policy) {
                                DevicePolicyRow(policy: policy)
                            }
                            .buttonStyle(.borderless)
                            .tint(.primary)
                        }
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                    }
                }

                Text("Secure login and automated access provided by Harmmonize.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .navigationDestination(for: Policy.self, destination: PolicyDetailView.init)
        }

        .frame(minWidth: 450, minHeight: 550)
        .fixedSize()
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
