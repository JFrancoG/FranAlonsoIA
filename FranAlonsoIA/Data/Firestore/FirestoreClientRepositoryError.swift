//
//  FirestoreClientRepositoryError.swift
//  FranAlonsoIA
//
//  Created by Codex on 12.01.2026.
//

enum FirestoreClientRepositoryError: Error {
    case missingData(documentId: String)
    case invalidData(documentId: String, field: String)
}
