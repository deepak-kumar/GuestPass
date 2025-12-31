//
//  GuestPassQRApp.swift
//  GuestPassQR
//
//  Created on 2025-12-15.
//

import SwiftUI

@main
struct GuestPassQRApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        #endif
    }
}
