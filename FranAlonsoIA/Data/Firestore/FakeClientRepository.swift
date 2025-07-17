//
//  FakeClientRepository.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.07.2025.
//

import Foundation

final class FakeClientRepository: ClientRepository {
    func getAllClients() async throws -> [Client] {
        return [
            Client(
                id: "1",
                fullName: "Fran Alonso",
                phones: ["666123123"],
                email: "fran@example.com",
                gender: "male",
                billingAddress: nil,
                birthDate: nil,
                colorRecipe: "Rubio dorado",
                lastColorDate: nil,
                profilePhotoUrl: nil,
                consentFormUrl: nil,
                notes: "Cliente habitual",
                isActive: true
            ),
            Client(
                id: "2",
                fullName: "Lucía Gómez",
                phones: ["666888999", "666777666"],
                email: nil,
                gender: "female",
                billingAddress: nil,
                birthDate: nil,
                colorRecipe: nil,
                lastColorDate: nil,
                profilePhotoUrl: nil,
                consentFormUrl: nil,
                notes: nil,
                isActive: true
            )
        ]
    }
}
