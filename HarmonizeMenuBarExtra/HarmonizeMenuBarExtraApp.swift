//
//  HarmonizeMenuBarExtraApp.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//
import SwiftUI

@main
struct HarmonizeMenuBarExtraApp: App {
    @Environment(\.colorScheme) var colorScheme
    @State private var networkManager = NetworkManager(environment: .staging)

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .environment(\.networkManager, networkManager)
        } label: {
            Image("harmonize-symbol-white-32px")
                .renderingMode(.template)
        }
        .menuBarExtraStyle(.window)
    }
}
