//
//  RequestAccessView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/17/23.
//

import SwiftUI

struct RequestAccessView: View {
    var application: Application
    
    enum Role {
        case admin
        case user
        case auditor
        case viewer
    }
    
    @State private var roleSelection: Role = .admin
    var body: some View {
        VStack {
            HStack {
                Picker("Role", selection: $roleSelection) {
                    Text("Admin")
                    Text("User")
                    Text("Auditor")
                    Text("Viewer")
                }
            }
        }
    }
}

struct RequestAccessView_Previews: PreviewProvider {
    static var previews: some View {
        RequestAccessView(application: .example)
    }
}
