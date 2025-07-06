//
//  Config.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation
struct Config: Codable, Equatable {
    var lastTimestamps: [String: Date]
    var versions: AppVersions
    var featureFlags: [String: Bool]
    var cacheExpirationMinutes: Int
    var otherConfig: [String: CodableValue] // flexible para tipos mixtos
}

extension Config {
    func lastUpdated(for key: ConfigKey) -> Date? {
        lastTimestamps[key.rawValue]
    }
}

enum ConfigKey: String {
    case products
    case orders
    case containers
    case measures
    case users
}

struct AppVersions: Codable, Equatable {
    var ios: VersionInfo
    var android: VersionInfo
}

struct VersionInfo: Codable, Equatable {
    var min: String
    var current: String
}

enum CodableValue: Codable, Equatable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intVal = try? container.decode(Int.self) {
            self = .int(intVal)
        } else if let doubleVal = try? container.decode(Double.self) {
            self = .double(doubleVal)
        } else if let boolVal = try? container.decode(Bool.self) {
            self = .bool(boolVal)
        } else if let stringVal = try? container.decode(String.self) {
            self = .string(stringVal)
        } else {
            throw DecodingError.typeMismatch(CodableValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unsupported value"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intVal): try container.encode(intVal)
        case .double(let doubleVal): try container.encode(doubleVal)
        case .bool(let boolVal): try container.encode(boolVal)
        case .string(let stringVal): try container.encode(stringVal)
        }
    }
    
    static func == (lhs: CodableValue, rhs: CodableValue) -> Bool {
        switch (lhs, rhs) {
        case let (.int(a), .int(b)): return a == b
        case let (.double(a), .double(b)): return a == b
        case let (.bool(a), .bool(b)): return a == b
        case let (.string(a), .string(b)): return a == b
        default: return false
        }
    }
}
