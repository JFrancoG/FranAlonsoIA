//
//  Service.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

struct Service: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let durationMinutes: Int
    let price: Decimal
    let items: [ServiceItem]
    let notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        durationMinutes: Int,
        price: Decimal,
        items: [ServiceItem] = [],
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.durationMinutes = durationMinutes
        self.price = price
        self.items = items
        self.notes = notes
    }
}

struct ServiceItem: Codable, Equatable {
    let productId: UUID
    let quantity: Int
}
