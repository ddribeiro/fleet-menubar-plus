//
//  AppRowView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/12/23.
//

import SwiftUI

struct AppRowView: View {
    var application: Application

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .frame(width: 44, height: 44)
                Image(application.name.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
            }

            VStack(alignment: .leading) {
                Text(application.name)
                    .font(.headline)
                HStack {
                    Text(application.active.capitalized)
                    if let access = application.accessLevel {
                        Text("•")
                        Text(access)
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.regularMaterial)
    }
}

struct AppRowView_Previews: PreviewProvider {
    static var previews: some View {
        AppRowView(application: Application(id: 3, name: "Zoom", active: "active", entitled: true))
    }
}
