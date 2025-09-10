//
//  FSCollection.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.07.2025.
//

import Foundation

enum FSCollection: String {
    case clients
    case services
    case appointments
    case sales
    case products
    case config

    var name: String { self.rawValue }

    var rootPath: String {
        return "\(FSEnvironment.current.rawValue)/collections/\(self.name)"
    }

    var rootCollectionName: String {
        return "\(FSEnvironment.current.rawValue)/collections"
    }
}
