//
//  AppCardView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/25/23.
//

import SwiftUI

struct AppCardView: View {
    var application: LibraryApp

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .frame(width: 44, height: 44)
                Image(application.name.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
            }
            Text(application.name)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text(application.description)
                .font(.subheadline)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

struct AppCardView_Previews: PreviewProvider {
    static var previews: some View {
        AppCardView(application: LibraryApp(id: 8, name: "Zoom", description: "Video Conferencing"))
    }
}
