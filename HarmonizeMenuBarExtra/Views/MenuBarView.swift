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
                    .background(.regularMaterial)
                }
                .containerShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .fixedSize(horizontal: false, vertical: true)
                .padding([.horizontal, .bottom], 16)
                
                Divider()
                
                HStack {
                    Text("My Device Health")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                List {
                    ForEach(user.user.devices) { device in
                        ForEach(device.policies) { policy in
                            HStack {
                                Image(systemName: policy.response == "pass" ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(policy.response == "pass" ? .green : .red)
                                Text(policy.name)
                                Spacer()
                            }
                        }
                        .padding()
                        .listRowSeparator(.visible)
                        .listRowSeparatorTint(.secondary)
                    }
                }
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                Text("Secure login and automated access provided by Harmmonize.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .frame(minWidth: 400, minHeight: 550)
        .fixedSize()
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
