//
//  UserPreviewView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct UserPreviewView: View {
    var user: UserDetail
    var host: Host?

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.gravatarUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(.secondary, lineWidth: 1)
                                .opacity(0.1)
                                .frame(width: 44)
                        )
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }

            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                if let host = host {
                    HStack {
                        VStack {
                            Image(systemName: "laptopcomputer")
                            Image(systemName: "building.2")
                        }
                        VStack(alignment: .leading) {
                            Text(host.computerName)
                                .foregroundColor(.secondary)
                            Text(user.company)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct UserPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreviewView(user: .example, host: .example )
    }
}
