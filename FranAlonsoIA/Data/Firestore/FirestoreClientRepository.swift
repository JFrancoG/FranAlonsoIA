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
        let data = FirestoreClientCodec.data(from: client)
        try await setData(data, for: FirestoreRefManager.clients.document(client.id), merge: false)
    }

    func updateClient(_ client: Client) async throws {
        let data = FirestoreClientCodec.data(from: client)
        try await setData(data, for: FirestoreRefManager.clients.document(client.id), merge: true)
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
        return try FirestoreClientCodec.client(from: document.documentID, data: data)
    }
}
