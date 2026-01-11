//
//  Product.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

struct Product: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var brand: String?
    var category: String?
    var volume: String?
    var stock: Int
    var minStock: Int?
    var isActive: Bool
    var lastUpdated: Date?
    var notes: String?

    // Inicializador con valores por defecto
    init(
        id: String = UUID().uuidString,
        name: String = "",
        brand: String? = nil,
        category: String? = nil,
        volume: String? = nil,
        stock: Int = 0,
        minStock: Int? = nil,
        isActive: Bool = true,
        lastUpdated: Date? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.brand = brand
        self.category = category
        self.volume = volume
        self.stock = stock
        self.minStock = minStock
        self.isActive = isActive
        self.lastUpdated = lastUpdated
        self.notes = notes
    }

    // Propiedad computada para formatear lastUpdated
    var formattedLastUpdated: String {
        guard let date = lastUpdated else { return "Sin fecha" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
