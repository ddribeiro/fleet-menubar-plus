//
//  ViewGroupsCard.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct ViewGroupsCard: View {
    var body: some View {
        VStack {
            Image(systemName: "person.3")
                .imageScale(.large)
                .padding(.vertical, 1)
                
            
            Text("View My Groups")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80)
        .padding()
    }
}

struct ViewGroupsCard_Previews: PreviewProvider {
    static var previews: some View {
        ViewGroupsCard()
    }
}
