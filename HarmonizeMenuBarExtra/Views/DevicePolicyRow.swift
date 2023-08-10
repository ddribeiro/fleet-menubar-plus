//
//  DevicePolicyRow.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/17/23.
//

import SwiftUI

struct DevicePolicyRow: View {
    var policy: FleetPolicy
    var body: some View {
        HStack {
            Image(systemName: policy.response == "pass" ? "checkmark.circle.fill" : "xmark.circle.fill")
                .imageScale(.large)
                .foregroundColor(policy.response == "pass" ? .green : .red)
            VStack(alignment: .leading) {
                Text(policy.name)
                    .font(.headline)
                Text(policy.response.capitalized)
                    .foregroundColor(.secondary)
                }
            .multilineTextAlignment(.leading)
            Spacer()

            Image(systemName: "chevron.forward")
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct DevicePolicyRow_Previews: PreviewProvider {
    static var previews: some View {
        DevicePolicyRow(policy: .example)
    }
}
