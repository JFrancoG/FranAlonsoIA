//
//  Client.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

struct Client: Identifiable, Codable, Equatable {
    var id: String
    var fullName: String
    var phones: [String]
    var email: String?
    var gender: String?

    var billingAddress: BillingAddress?
    var birthDate: Date?
    var colorRecipe: String?
    var lastColorDate: Date?

    var profilePhotoUrl: String?
    var consentFormUrl: String?

    var notes: String?
    var isActive: Bool
}

struct BillingAddress: Codable, Equatable {
    var street: String
    var postalCode: String
    var city: String
    var province: String
}
