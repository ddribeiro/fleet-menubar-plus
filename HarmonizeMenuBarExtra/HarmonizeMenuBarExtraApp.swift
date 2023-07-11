//
//  HarmonizeMenuBarExtraApp.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import SwiftUI

@main
struct HarmonizeMenuBarExtraApp: App {
    @AppStorage("showMenuBarExtrass") private var showMenuBarExtra = true
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        MenuBarExtra("Harmonize Menu Bar Extra", image: colorScheme == .light ? "harmonize-symbol-black-32px" : "harmonize-symbol-white-32px") {
            MenuBarView()
        }
        .menuBarExtraStyle(.window)
    }
}
