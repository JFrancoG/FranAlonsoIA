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
        let data = clientData(from: dto, includeId: true)
        try await setData(data, for: FirestoreRefManager.clients.document(dto.id), merge: false)
    }

    func updateClient(_ client: Client) async throws {
        let dto = ClientMapper.toDTO(from: client)
        let data = clientData(from: dto, includeId: true)
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

        let dto = ClientDTO(
            id: (data["id"] as? String) ?? document.documentID,
            fullName: fullName,
            phones: phones,
            email: data["email"] as? String,
            gender: data["gender"] as? String,
            billingAddress: billingAddress,
            birthDate: dateValue(from: data["birthDate"]),
            colorRecipe: data["colorRecipe"] as? String,
            lastColorDate: dateValue(from: data["lastColorDate"]),
            profilePhotoUrl: data["profilePhotoUrl"] as? String,
            consentFormUrl: data["consentFormUrl"] as? String,
            notes: data["notes"] as? String,
            isActive: data["isActive"] as? Bool ?? true,
            lastUpdated: dateValue(from: data["lastUpdated"])
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

    func dateValue(from value: Any?) -> Date? {
        if let timestamp = value as? Timestamp {
            return timestamp.dateValue()
        }
        return value as? Date
    }

    func clientData(from dto: ClientDTO, includeId: Bool) -> [String: Any] {
        var data: [String: Any] = [
            "fullName": dto.fullName,
            "phones": dto.phones,
            "isActive": dto.isActive
        ]

        if includeId {
            data["id"] = dto.id
        }

        data["email"] = dto.email
        data["gender"] = dto.gender
        data["colorRecipe"] = dto.colorRecipe
        data["profilePhotoUrl"] = dto.profilePhotoUrl
        data["consentFormUrl"] = dto.consentFormUrl
        data["notes"] = dto.notes

        if let billingAddress = dto.billingAddress {
            data["billingAddress"] = [
                "street": billingAddress.street,
                "postalCode": billingAddress.postalCode,
                "city": billingAddress.city,
                "province": billingAddress.province
            ]
        }

        if let birthDate = dto.birthDate {
            data["birthDate"] = Timestamp(date: birthDate)
        }

        if let lastColorDate = dto.lastColorDate {
            data["lastColorDate"] = Timestamp(date: lastColorDate)
        }

        data["lastUpdated"] = Timestamp(date: dto.lastUpdated ?? Date())

        return data
    }
}
