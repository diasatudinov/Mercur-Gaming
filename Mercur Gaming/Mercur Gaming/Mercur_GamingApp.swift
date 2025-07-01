//
//  Mercur_GamingApp.swift
//  Mercur Gaming
//
//

import SwiftUI

@main
struct Mercur_GamingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MEGRoot()
                .preferredColorScheme(.light)
        }
    }
}
