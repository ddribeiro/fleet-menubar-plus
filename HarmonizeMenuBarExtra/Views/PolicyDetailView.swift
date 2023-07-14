//
//  PolicyDetailView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/14/23.
//

import SwiftUI

struct PolicyDetailView: View {
    var policy: Policy
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Description:")
                    .font(.headline)
                Text(policy.description)
                    .padding(.bottom)
                    .lineLimit(3)
                Text("Resolution:")
                    .font(.headline)
                Text(policy.resolution)
                    .lineLimit(.max)
            }
            .padding()
            .navigationTitle(policy.name)
            .frame(width: 400)
        }
}

struct PolicyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyDetailView(policy: .example)
    }
}
