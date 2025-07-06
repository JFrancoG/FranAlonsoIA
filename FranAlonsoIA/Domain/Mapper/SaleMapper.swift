//
//  SaleMapper.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

// Modelo de datos para persistencia o red
struct SaleDTO: Codable, Equatable {
    let id: UUID
    let clientId: UUID
    let date: Date
    let items: [SaleItemDTO]
    let total: Decimal
    let notes: String?
}

struct SaleItemDTO: Codable, Equatable {
    let productId: UUID
    let quantity: Int
    let price: Decimal
}

// Mapper entre SaleDTO y Sale del dominio
struct SaleMapper {
    static func toDomain(from dto: SaleDTO) -> Sale {
        return Sale(
            id: dto.id,
            clientId: dto.clientId,
            date: dto.date,
            items: dto.items.map {
                SaleItem(
                    productId: $0.productId,
                    quantity: $0.quantity,
                    price: $0.price
                )
            },
            total: dto.total,
            notes: dto.notes
        )
    }

    static func toDTO(from sale: Sale) -> SaleDTO {
        return SaleDTO(
            id: sale.id,
            clientId: sale.clientId,
            date: sale.date,
            items: sale.items.map {
                SaleItemDTO(
                    productId: $0.productId,
                    quantity: $0.quantity,
                    price: $0.price
                )
            },
            total: sale.total,
            notes: sale.notes
        )
    }
}
