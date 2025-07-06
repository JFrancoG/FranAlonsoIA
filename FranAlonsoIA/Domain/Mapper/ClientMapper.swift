//
//  ClientMapper.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

// Modelo de datos para persistencia o red
struct ClientDTO: Codable, Equatable {
    let id: String
    let fullName: String
    let phones: [String]
    let email: String?
    let gender: String?
    let billingAddress: BillingAddressDTO?
    let birthDate: Date?
    let colorRecipe: String?
    let lastColorDate: Date?
    let profilePhotoUrl: String?
    let consentFormUrl: String?
    let notes: String?
    let isActive: Bool
    let lastUpdated: Date?
}

// Submodelo auxiliar
struct BillingAddressDTO: Codable, Equatable {
    let street: String
    let postalCode: String
    let city: String
    let province: String
}

// Mapper entre ClientDTO y Client del dominio
struct ClientMapper {
    
    static func toDomain(from dto: ClientDTO) -> Client {
        return Client(
            id: dto.id,
            fullName: dto.fullName,
            phones: dto.phones,
            email: dto.email,
            gender: dto.gender,
            billingAddress: dto.billingAddress.map {
                BillingAddress(
                    street: $0.street,
                    postalCode: $0.postalCode,
                    city: $0.city,
                    province: $0.province
                )
            },
            birthDate: dto.birthDate,
            colorRecipe: dto.colorRecipe,
            lastColorDate: dto.lastColorDate,
            profilePhotoUrl: dto.profilePhotoUrl,
            consentFormUrl: dto.consentFormUrl,
            notes: dto.notes,
            isActive: dto.isActive
        )
    }
    
    static func toDTO(from client: Client) -> ClientDTO {
        return ClientDTO(
            id: client.id,
            fullName: client.fullName,
            phones: client.phones,
            email: client.email,
            gender: client.gender,
            billingAddress: client.billingAddress.map {
                BillingAddressDTO(
                    street: $0.street,
                    postalCode: $0.postalCode,
                    city: $0.city,
                    province: $0.province
                )
            },
            birthDate: client.birthDate,
            colorRecipe: client.colorRecipe,
            lastColorDate: client.lastColorDate,
            profilePhotoUrl: client.profilePhotoUrl,
            consentFormUrl: client.consentFormUrl,
            notes: client.notes,
            isActive: client.isActive,
            lastUpdated: nil
        )
    }
}
