//
//  ProductMapper.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

// Modelo de datos para persistencia o red
struct ProductDTO: Codable, Equatable {
    let id: String
    let name: String
    let brand: String?
    let category: String?
    let volume: String?
    let stock: Int
    let minStock: Int?
    let isActive: Bool
    let lastUpdated: Date?
    let notes: String?
}

// Mapper entre ProductDTO y Product del dominio
struct ProductMapper {

    static func toDomain(from dto: ProductDTO) -> Product {
        return Product(
            id: dto.id,
            name: dto.name,
            brand: dto.brand,
            category: dto.category,
            volume: dto.volume,
            stock: dto.stock,
            minStock: dto.minStock,
            isActive: dto.isActive,
            lastUpdated: dto.lastUpdated,
            notes: dto.notes
        )
    }

    static func toDTO(from product: Product) -> ProductDTO {
        return ProductDTO(
            id: product.id,
            name: product.name,
            brand: product.brand,
            category: product.category,
            volume: product.volume,
            stock: product.stock,
            minStock: product.minStock,
            isActive: product.isActive,
            lastUpdated: product.lastUpdated,
            notes: product.notes
        )
    }
}
