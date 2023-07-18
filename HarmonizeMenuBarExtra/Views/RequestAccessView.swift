//
//  RequestAccessView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/17/23.
//

import SwiftUI

struct RequestAccessView: View {
    
    enum Role: CaseIterable {
        case admin
        case user
        case auditor
        case viewer
    }
    
    @State private var roleSelection: Role = .admin
    @State private var endDate = Date.now
    @State private var reasonTextField = ""
    
    var body: some View {
        VStack {
            HStack {
                Picker("Role", selection: $roleSelection) {
                    ForEach(Role.allCases, id: \.self) {
                        Text("\($0)".capitalized)
                    }
                }
                .labelsHidden()
                Spacer()
                DatePicker(selection: $endDate, in: ...Date.distantFuture, displayedComponents: .date) {
                    Text("Select a date")
                }
            }
            ScrollView {
                TextField("Reason", text: $reasonTextField)
                    .allowsTightening(true)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 400, maxHeight: .infinity)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
        }
        .navigationTitle("Request App Access")
        .padding()
    }
}

struct RequestAccessView_Previews: PreviewProvider {
    static var previews: some View {
        RequestAccessView()
    }
}
