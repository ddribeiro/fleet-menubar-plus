//
//  AppLibraryView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/18/23.
//

import SwiftUI

struct AppLibraryView: View {
    var applications: ApplicationResponse = Bundle.main.decode(ApplicationResponse.self, from: "applications.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(applications.applications) { application in
                    NavigationLink {
                        RequestAccessView()
                    } label: {
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
                            Text(application.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(.borderless)
                    .tint(.primary)
                }
            }
        }
        .padding()
        .navigationTitle("App Library")
        .frame(maxWidth: 400, minHeight: 550)
    }
}

struct AppLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        AppLibraryView()
    }
}
