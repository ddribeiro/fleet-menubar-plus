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
        GridItem(.adaptive(minimum: 130))
    ]

    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("􀊫 Search", text: $searchText)
                .padding([.horizontal, .top])
                .textFieldStyle(.roundedBorder)

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(applications.applications) { application in
                        NavigationLink {
                            RequestAccessView()
                        } label: {
                            AppCardView(application: application)
                        }
                        .padding()
                        .buttonStyle(.borderless)
                        .tint(.primary)
                    }
                    .frame(width: 130, height: 130)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 450)
        .navigationTitle("App Library")

        Spacer()
    }

}

struct AppLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        AppLibraryView()
    }
}
