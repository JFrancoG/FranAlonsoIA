//
//  FranAlonsoIAApp.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 05.07.2025.
//

import SwiftUI
import FirebaseCore

extension ProcessInfo {
    var isSwiftUIPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

@main
struct FranAlonsoIAApp: App {
    init() {
        print("🧪 Running with environment:", ProcessInfo.processInfo.environment)
        if !ProcessInfo.processInfo.isSwiftUIPreview &&
           ProcessInfo.processInfo.environment["IS_RUNNING_TESTS"] != "YES" {
            print("✅ Configurando Firebase")
            FirebaseApp.configure()
        } else {
            print("⛔️ NO configuramos Firebase")
        }
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
