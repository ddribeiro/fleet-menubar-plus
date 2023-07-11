//
//  MenuBarView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct MenuBarView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
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
                UserPreviewView()
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
                            ViewAppAccessCard()
                            ViewGroupsCard()
                        }
                        .background(.thickMaterial)
                    }
                    .containerShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.horizontal, .bottom], 16)
                    .frame(maxWidth: 12000)
            
            Divider()
            
            HStack {
                Text("My Device Health")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            Form {
                Group {
                    HStack {
                        Text("Disk Space")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    HStack {
                        Text("Battery Health")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Disk Encryption")
                        Spacer()
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.red)
                        
                    }
                    
                    Divider()
    
                    HStack {
                        Text("Warranty Status")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    .padding(.bottom)
                }
                .padding(.vertical, 3)
                .padding(.horizontal)
            }
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            Text("Secure login and automated access provided by Harmmonize.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding()
    
                
            
            
        }
        .background(.ultraThinMaterial)
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
