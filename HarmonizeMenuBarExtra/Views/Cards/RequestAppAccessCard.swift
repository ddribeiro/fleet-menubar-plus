//
//  RequestAppAccessCard.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

struct RequestAppAccessCard: View {
    var body: some View {
        NavigationLink {
            AppLibraryView()
        } label: {
            VStack {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .padding(.vertical, 1)

                Text("Request App Access")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        }
        .buttonStyle(.borderless)
        .tint(.primary)
        .frame(width: 80)
        .padding()
    }
}

struct RequestAppAccessCard_Previews: PreviewProvider {
    static var previews: some View {
        RequestAppAccessCard()
    }
}
