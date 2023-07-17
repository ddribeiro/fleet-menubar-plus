//
//  MyAppAccessView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/12/23.
//

import SwiftUI

struct MyAppAccessView: View {
    var applications: [Application]
    
    var filteredApplications: [Application] {
        return applications.filter { application in
            if activeSelected {
                if application.active == "active" {
                    return true
                }
            }
            
            if pendingSelected {
                if application.active == "pending" {
                    return true
                }
            }
            
            if closedSelected {
                if application.active == "closed" {
                    return true
                }
            }
            
            return false
        }
    }
    
    var searchResults: [Application] {
        if searchText.isEmpty {
            return filteredApplications
        } else {
            return filteredApplications.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @State private var searchText = ""
    @State private var pickerSelection = "Pending"
    @State private var pickerOptions = ["Pending", "Active", "Closed"]
    @State private var activeSelected = true
    @State private var pendingSelected = false
    @State private var closedSelected = false
    
    var body: some View {
        VStack {
            TextField("􀊫 Search", text: $searchText)
                .padding([.horizontal, .top])
                .textFieldStyle(.roundedBorder)
                .searchable(text: $searchText, placement: .automatic)
            
            HStack {
                Toggle("Active", isOn: $activeSelected)
                Toggle("Pending", isOn: $pendingSelected)
                Toggle("Closed", isOn: $closedSelected)
                
                Spacer()
            }
            .padding(.horizontal)
            .toggleStyle(.button)
            
            List {
                ForEach(searchResults) { application in
                    AppRowView(application: application)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                .scaledToFill()
            }
        }
        .navigationTitle("My App Access")
        .frame(minWidth: 400, minHeight: 550)
        .fixedSize()
    }
}

struct MyAppAccessView_Previews: PreviewProvider {
    static var previews: some View {
        MyAppAccessView(applications: [.example, .example, .example, .example])
    }
}
