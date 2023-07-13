//
//  MyAppAccessView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/12/23.
//

import SwiftUI

struct MyAppAccessView: View {
    var applications: [Application]
    @State private var searchText = ""
    @State private var pickerSelection = "Pending"
    @State private var pickerOptions = ["Pending", "Active", "Closed"]
    var body: some View {
        VStack {
            Picker(" ", selection: $pickerSelection) {
                ForEach(pickerOptions, id: \.self) {
                    Text($0)
                }
            }
            .padding(.trailing)
            .pickerStyle(.segmented)
            List {
                ForEach(applications) { application in
                    AppRowView(application: application)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
            }
            .searchable(text: $searchText, placement: .toolbar)
        }
        .padding(.top)
        .navigationTitle("My Apps")
        .frame(width: 400)
    }
}

struct MyAppAccessView_Previews: PreviewProvider {
    static var previews: some View {
        MyAppAccessView(applications: [.example, .example, .example, .example])
    }
}
