//
//  Squad_DEVApp.swift
//  Squad_DEV
//
//  Created by Даниил Храповицкий on 22.05.2021.
//

import SwiftUI
import AppKit
import Firebase

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}

@main
struct Squad_DEVApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
