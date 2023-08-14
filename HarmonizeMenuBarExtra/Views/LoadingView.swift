//
//  LoadingView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 8/14/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading Device Policies from Fleet")
                .foregroundColor(.secondary)
                .padding()
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
