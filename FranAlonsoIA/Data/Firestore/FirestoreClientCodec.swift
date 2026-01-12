//
//  FirestoreClientCodec.swift
//  FranAlonsoIA
//
//  Created by Codex on 12.01.2026.
//

import Foundation
import FirebaseFirestore

struct FirestoreClientCodec {
    private static let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    private static let inputDateFormatters: [DateFormatter] = {
        let formats = ["dd/MM/yyyy", "d/M/yyyy", "yyyy-MM-dd", "yyyy/MM/dd"]
        return formats.map { format in
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "es_ES")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = format
            return formatter
        }
    }()

    static func client(from documentId: String, data: [String: Any]) throws -> Client {
        guard let fullName = data["full_name"] as? String else {
            throw FirestoreClientRepositoryError.invalidData(documentId: documentId, field: "full_name")
        }

        let phones = data["phones"] as? [String] ?? []
        let billingAddress = billingAddressDTO(from: data["billing_address"])

        let dto = ClientDTO(
            id: documentId,
            fullName: fullName,
            phones: phones,
            email: stringValue(from: data["email"]),
            billingAddress: billingAddress,
            birthDate: dateValue(from: data["birth_date"]),
            recipe: stringValue(from: data["recipe"]),
            lastColorDate: dateValue(from: data["last_color_date"]),
            photoUrl: stringValue(from: data["photo_url"]),
            consentUrl: stringValue(from: data["consent_url"]),
            notes: stringValue(from: data["notes"]),
            isActive: data["is_active"] as? Bool ?? true
        )

        return ClientMapper.toDomain(from: dto)
    }

    static func data(from client: Client) -> [String: Any] {
        let dto = ClientMapper.toDTO(from: client)
        var data: [String: Any] = [
            "full_name": dto.fullName,
            "phones": dto.phones,
            "is_active": dto.isActive,
            "email": dto.email ?? "",
            "recipe": dto.recipe ?? "",
            "photo_url": dto.photoUrl ?? "",
            "consent_url": dto.consentUrl ?? "",
            "notes": dto.notes ?? "",
            "birth_date": dateString(from: dto.birthDate),
            "last_color_date": dateString(from: dto.lastColorDate)
        ]

        if let billingAddress = dto.billingAddress {
            data["billing_address"] = [
                "street": billingAddress.street,
                "postal_code": billingAddress.postalCode,
                "city": billingAddress.city,
                "province": billingAddress.province
            ]
        } else {
            data["billing_address"] = NSNull()
        }

        return data
    }

    private static func billingAddressDTO(from value: Any?) -> BillingAddressDTO? {
        guard let data = value as? [String: Any] else {
            return nil
        }
        guard
            let street = data["street"] as? String,
            let postalCode = data["postal_code"] as? String,
            let city = data["city"] as? String,
            let province = data["province"] as? String
        else {
            return nil
        }
        return BillingAddressDTO(
            street: street,
            postalCode: postalCode,
            city: city,
            province: province
        )
    }

    private static func stringValue(from value: Any?) -> String? {
        guard let string = value as? String else {
            return nil
        }
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    private static func dateValue(from value: Any?) -> Date? {
        if let timestamp = value as? Timestamp {
            return timestamp.dateValue()
        }
        if let date = value as? Date {
            return date
        }
        guard let string = value as? String else {
            return nil
        }
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return nil
        }
        for formatter in inputDateFormatters {
            if let date = formatter.date(from: trimmed) {
                return date
            }
        }
        return nil
    }

    private static func dateString(from date: Date?) -> String {
        guard let date else {
            return ""
        }
        return outputDateFormatter.string(from: date)
    }
}
