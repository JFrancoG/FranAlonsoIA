//
//  ServiceMapper.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

// Modelo de datos para persistencia o red
struct ServiceDTO: Codable, Equatable {
    let id: UUID
    let name: String
    let durationMinutes: Int
    let price: Decimal
    let items: [ServiceItemDTO]
    let notes: String?
}

struct ServiceItemDTO: Codable, Equatable {
    let productId: UUID
    let quantity: Int
}

// Mapper entre ServiceDTO y Service del dominio
struct ServiceMapper {
    static func toDomain(from dto: ServiceDTO) -> Service {
        return Service(
            id: dto.id,
            name: dto.name,
            durationMinutes: dto.durationMinutes,
            price: dto.price,
            items: dto.items.map {
                ServiceItem(
                    productId: $0.productId,
                    quantity: $0.quantity
                )
            },
            notes: dto.notes
        )
    }

    static func toDTO(from service: Service) -> ServiceDTO {
        return ServiceDTO(
            id: service.id,
            name: service.name,
            durationMinutes: service.durationMinutes,
            price: service.price,
            items: service.items.map {
                ServiceItemDTO(
                    productId: $0.productId,
                    quantity: $0.quantity
                )
            },
            notes: service.notes
        )
    }
}
