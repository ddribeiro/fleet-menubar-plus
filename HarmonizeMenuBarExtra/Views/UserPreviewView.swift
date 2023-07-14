//
//  UserPreviewView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct UserPreviewView: View {
    var user: UserDetail
    
    var body: some View {
        HStack {
            Image("dale")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                HStack {
                    Image(systemName: "building.2")
                    Text(user.company)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct UserPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreviewView(user: .example )
    }
}
