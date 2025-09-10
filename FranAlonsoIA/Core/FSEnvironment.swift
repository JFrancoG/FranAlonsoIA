//
//  FSEnvironment.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.07.2025.
//

import Foundation

enum FSEnvironment: String {
    case develop
    case production

    static var current: FSEnvironment {
        #if DEBUG
        return .develop
        #else
        return .production
        #endif
    }
}
