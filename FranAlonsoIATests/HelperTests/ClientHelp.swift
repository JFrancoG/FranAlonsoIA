//
//  ClientHelp.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 12.09.2025.
//

@testable import FranAlonsoIA

extension Client {
    static func fake(
        id: String,
        name: String,
        phones: [String] = [],
        isActive: Bool = true
    ) -> Client {
        Client(
            id: id,
            fullName: name,
            phones: phones,
            email: nil,
            billingAddress: nil,
            birthDate: nil,
            recipe: nil,
            lastColorDate: nil,
            photoUrl: nil,
            consentUrl: nil,
            notes: nil,
            isActive: isActive
        )
    }
}
