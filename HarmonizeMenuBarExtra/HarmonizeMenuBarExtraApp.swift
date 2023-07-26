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

    var body: some Scene {
        WindowGroup {
            RequestAccessView()
        }
        MenuBarExtra("Harmonize Menu Bar Extra", image: "harmonize-symbol-black-32px") {
            MenuBarView()
        }
        .menuBarExtraStyle(.window)
    }
}
