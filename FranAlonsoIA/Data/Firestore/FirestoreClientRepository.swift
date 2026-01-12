//
//  FirestoreClientRepository.swift
//  FranAlonsoIA
//
//  Created by Codex on 12.01.2026.
//

import FirebaseFirestore

enum FirestoreClientRepositoryError: Error {
    case missingData(documentId: String)
    case invalidData(documentId: String, field: String)
}

final class FirestoreClientRepository: ClientRepository {
    private static let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "d/M/yyyy"
        return formatter
    }()

    private static let inputDateFormatters: [DateFormatter] = {
        let formats = ["d/M/yyyy", "dd/MM/yyyy", "yyyy-MM-dd", "yyyy/MM/dd"]
        return formats.map { format in
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "es_ES")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = format
            return formatter
        }
    }()

    func getAllClients() async throws -> [Client] {
        let snapshot = try await getDocuments(from: FirestoreRefManager.clients)
        return try snapshot.documents.map { try client(from: $0) }
    }

    func getClient(id: String) async throws -> Client? {
        let document = try await getDocument(for: FirestoreRefManager.clients.document(id))
        guard document.exists else {
            return nil
        }
        return try client(from: document)
    }

    func createClient(_ client: Client) async throws {
        let dto = ClientMapper.toDTO(from: client)
        let data = clientData(from: dto)
        try await setData(data, for: FirestoreRefManager.clients.document(dto.id), merge: false)
    }

    func updateClient(_ client: Client) async throws {
        let dto = ClientMapper.toDTO(from: client)
        let data = clientData(from: dto)
        try await setData(data, for: FirestoreRefManager.clients.document(dto.id), merge: true)
    }

    func deleteClient(id: String) async throws {
        try await deleteDocument(for: FirestoreRefManager.clients.document(id))
    }
}

private extension FirestoreClientRepository {
    func getDocuments(from collection: CollectionReference) async throws -> QuerySnapshot {
        try await withCheckedThrowingContinuation { continuation in
            collection.getDocuments { snapshot, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let snapshot else {
                    continuation.resume(throwing: FirestoreClientRepositoryError.missingData(documentId: "collection"))
                    return
                }
                continuation.resume(returning: snapshot)
            }
        }
    }

    func getDocument(for document: DocumentReference) async throws -> DocumentSnapshot {
        try await withCheckedThrowingContinuation { continuation in
            document.getDocument { snapshot, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let snapshot else {
                    continuation.resume(throwing: FirestoreClientRepositoryError.missingData(documentId: document.documentID))
                    return
                }
                continuation.resume(returning: snapshot)
            }
        }
    }

    func setData(_ data: [String: Any], for document: DocumentReference, merge: Bool) async throws {
        try await withCheckedThrowingContinuation { continuation in
            document.setData(data, merge: merge) { error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: ())
            }
        }
    }

    func deleteDocument(for document: DocumentReference) async throws {
        try await withCheckedThrowingContinuation { continuation in
            document.delete { error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: ())
            }
        }
    }

    func client(from document: DocumentSnapshot) throws -> Client {
        guard let data = document.data() else {
            throw FirestoreClientRepositoryError.missingData(documentId: document.documentID)
        }

        guard let fullName = data["full_name"] as? String else {
            throw FirestoreClientRepositoryError.invalidData(documentId: document.documentID, field: "full_name")
        }

        let phones = data["phones"] as? [String] ?? []
        let billingAddress = billingAddressDTO(from: data["billing_address"])

        let dto = ClientDTO(
            id: document.documentID,
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

    func billingAddressDTO(from value: Any?) -> BillingAddressDTO? {
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

    func stringValue(from value: Any?) -> String? {
        if let timestamp = value as? Timestamp {
            return FirestoreClientRepository.outputDateFormatter.string(from: timestamp.dateValue())
        }
        if let string = value as? String {
            let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else {
                return nil
            }
            return trimmed
        }
        return nil
    }

    func dateValue(from value: Any?) -> Date? {
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
        for formatter in FirestoreClientRepository.inputDateFormatters {
            if let date = formatter.date(from: trimmed) {
                return date
            }
        }
        return nil
    }

    func clientData(from dto: ClientDTO) -> [String: Any] {
        var data: [String: Any] = [
            "full_name": dto.fullName,
            "phones": dto.phones,
            "is_active": dto.isActive
        ]

        data["email"] = dto.email ?? ""
        data["recipe"] = dto.recipe ?? ""
        data["photo_url"] = dto.photoUrl ?? ""
        data["consent_url"] = dto.consentUrl ?? ""
        data["notes"] = dto.notes ?? ""

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

        data["birth_date"] = dateString(from: dto.birthDate)
        data["last_color_date"] = dateString(from: dto.lastColorDate)

        return data
    }

    func dateString(from date: Date?) -> String {
        guard let date else {
            return ""
        }
        return FirestoreClientRepository.outputDateFormatter.string(from: date)
    }
}
