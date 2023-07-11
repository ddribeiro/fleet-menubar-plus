//
//  ViewAppAccessCard.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct ViewAppAccessCard: View {
    var body: some View {
        VStack {
            Image(systemName: "key.horizontal")
                .imageScale(.large)
                .padding(.vertical, 1)
                
            
            Text("View My App Access")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80)
        .padding()
    }
}

struct ViewAppAccessCard_Previews: PreviewProvider {
    static var previews: some View {
        ViewAppAccessCard()
    }
}
