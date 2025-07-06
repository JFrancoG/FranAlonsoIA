//
//  Sale.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

struct Sale: Identifiable, Codable, Equatable {
    let id: UUID
    let clientId: UUID
    let date: Date
    let items: [SaleItem]
    let total: Decimal
    let notes: String?

    init(
        id: UUID = UUID(),
        clientId: UUID,
        date: Date = Date(),
        items: [SaleItem],
        total: Decimal,
        notes: String? = nil
    ) {
        self.id = id
        self.clientId = clientId
        self.date = date
        self.items = items
        self.total = total
        self.notes = notes
    }
}

struct SaleItem: Codable, Equatable {
    let productId: UUID
    let quantity: Int
    let price: Decimal
}
