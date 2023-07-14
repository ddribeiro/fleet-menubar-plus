//
//  MyAppAccessView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/12/23.
//

import SwiftUI

struct MyAppAccessView: View {
    var applications: [Application]
    var activeApplications: [Application] {
        return applications.filter({ $0.active })
    }
    var searchResults: [Application] {
        if searchText.isEmpty {
            return activeApplications
        } else {
            return activeApplications.filter { $0.name.contains(searchText) }
        }
    }
    
    enum SearchScope {
        case pending
        case active
        case closed
    }
    
    @State private var searchText = ""
    @State private var pickerSelection = "Pending"
    @State private var pickerOptions = ["Pending", "Active", "Closed"]
    @State private var scope: SearchScope = .active
    var body: some View {
        
        NavigationStack {
            TextField("􀊫 Search", text: $searchText)
                .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
                .searchable(text: $searchText, placement: .automatic)
                .searchScopes($scope) {
                    Text("Pending").tag(SearchScope.pending)
                    Text("Active").tag(SearchScope.active)
                    Text("Closed").tag(SearchScope.closed)
                }
            List {
                ForEach(searchResults) { application in
                    AppRowView(application: application)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
            }
            .searchable(text: $searchText, placement: .toolbar)
            
        }
        .navigationTitle("My App Access")
        .frame(width: 400)
    }
}

struct MyAppAccessView_Previews: PreviewProvider {
    static var previews: some View {
        MyAppAccessView(applications: [.example, .example, .example, .example])
    }
}
