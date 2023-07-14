//
//  AppRowView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/12/23.
//

import SwiftUI

struct AppRowView: View {
    var application: Application
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .frame(width: 40, height: 40)
                Image(application.name.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 25, maxHeight: 25)
            }
            
            VStack(alignment: .leading) {
                Text(application.name)
                    .font(.headline)
                HStack {
                    Text(application.active ? "Active" : "")
                    Image(systemName: "circle.fill")
                        .imageScale(.small)
                    Text("Viewer")
                }
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thickMaterial)
    }
}

struct AppRowView_Previews: PreviewProvider {
    static var previews: some View {
        AppRowView(application: .example)
    }
}
