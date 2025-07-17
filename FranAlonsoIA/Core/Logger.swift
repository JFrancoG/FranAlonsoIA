//
//  Logger.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 15.07.2025.
//

import Foundation
import os

enum Logger {
    static let subsystem = Bundle.main.bundleIdentifier ?? "FranAlonsoIA"

    static func log(_ message: String, category: String = "App") {
        let logger = os.Logger(subsystem: subsystem, category: category)
        logger.info("\(message, privacy: .public)")
    }

    static func error(_ message: String, category: String = "App") {
        let logger = os.Logger(subsystem: subsystem, category: category)
        logger.error("\(message, privacy: .public)")
    }
}
