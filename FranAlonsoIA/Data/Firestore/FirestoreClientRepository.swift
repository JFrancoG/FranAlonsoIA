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
    private static let dateFormatters: [DateFormatter] = {
        let formats = ["dd/MM/yyyy", "d/M/yyyy", "yyyy-MM-dd", "dd-MM-yyyy", "d-M-yyyy"]
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

        guard let fullName = data["fullName"] as? String else {
            throw FirestoreClientRepositoryError.invalidData(documentId: document.documentID, field: "fullName")
        }

        let phones = data["phones"] as? [String] ?? []
        let billingAddress = billingAddressDTO(from: data["billingAddress"])
            ?? addressDTO(from: data["address"])

        let dto = ClientDTO(
            id: document.documentID,
            fullName: fullName,
            phones: phones,
            email: data["email"] as? String,
            gender: nil,
            billingAddress: billingAddress,
            birthDate: dateValue(from: data["birthDate"]),
            colorRecipe: data["recipe"] as? String,
            lastColorDate: dateValue(from: data["colorDate"]),
            profilePhotoUrl: data["photoUrl"] as? String,
            consentFormUrl: data["consentUrl"] as? String,
            notes: data["notes"] as? String,
            isActive: data["isActive"] as? Bool ?? true,
            lastUpdated: nil
        )

        return ClientMapper.toDomain(from: dto)
    }

    func billingAddressDTO(from value: Any?) -> BillingAddressDTO? {
        guard let data = value as? [String: Any] else {
            return nil
        }
        guard
            let street = data["street"] as? String,
            let postalCode = data["postalCode"] as? String,
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

    func addressDTO(from value: Any?) -> BillingAddressDTO? {
        guard let address = value as? String else {
            return nil
        }
        let trimmed = address.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return nil
        }
        return BillingAddressDTO(
            street: trimmed,
            postalCode: "",
            city: "",
            province: ""
        )
    }

    func dateValue(from value: Any?) -> Date? {
        if let timestamp = value as? Timestamp {
            return timestamp.dateValue()
        }
        if let date = value as? Date {
            return date
        }
        if let string = value as? String {
            let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else {
                return nil
            }
            for formatter in FirestoreClientRepository.dateFormatters {
                if let date = formatter.date(from: trimmed) {
                    return date
                }
            }
        }
        return nil
    }

    func clientData(from dto: ClientDTO) -> [String: Any] {
        var data: [String: Any] = [
            "fullName": dto.fullName,
            "phones": dto.phones,
            "isActive": dto.isActive
        ]

        data["email"] = dto.email
        data["recipe"] = dto.colorRecipe
        data["photoUrl"] = dto.profilePhotoUrl
        data["consentUrl"] = dto.consentFormUrl
        data["notes"] = dto.notes

        if let billingAddress = dto.billingAddress {
            let components = [
                billingAddress.street,
                billingAddress.postalCode,
                billingAddress.city,
                billingAddress.province
            ].map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            let address = components.filter { !$0.isEmpty }.joined(separator: ", ")
            if !address.isEmpty {
                data["address"] = address
            }
        }

        if let birthDate = dto.birthDate {
            data["birthDate"] = Timestamp(date: birthDate)
        }

        if let lastColorDate = dto.lastColorDate {
            data["colorDate"] = Timestamp(date: lastColorDate)
        }

        return data
    }
}
