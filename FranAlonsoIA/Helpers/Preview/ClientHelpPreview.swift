//
//  ClientHelpPreview.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 12.09.2025.
//

import Foundation

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
            gender: nil,
            billingAddress: nil,
            birthDate: nil,
            colorRecipe: nil,
            lastColorDate: nil,
            profilePhotoUrl: nil,
            consentFormUrl: nil,
            notes: nil,
            isActive: isActive
        )
    }
}
