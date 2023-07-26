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
                if policy.response != "pass" {
                    HStack {
                        Spacer()
                        Image(systemName: "laptopcomputer.trianglebadge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(.primary)

                        Spacer()
                    }
                }

                Text("Description:")
                    .font(.headline)
                Text(policy.description)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom)
                    .lineLimit(3)
                Text("Resolution:")
                    .font(.headline)
                Text(policy.resolution)
                    .lineLimit(.max)
                    .fixedSize(horizontal: false, vertical: true)

            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 19, style: .continuous))
            .navigationTitle(policy.name)
            .frame(maxWidth: 400, minHeight: 550)
            .fixedSize()
        }
}

struct PolicyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyDetailView(policy: .example)
    }
}
