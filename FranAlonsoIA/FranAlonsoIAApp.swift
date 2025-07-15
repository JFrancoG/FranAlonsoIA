//
//  FranAlonsoIAApp.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 05.07.2025.
//

import SwiftUI
import FirebaseCore

@main
struct FranAlonsoIAApp: App {
    init() { FirebaseApp.configure() }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
