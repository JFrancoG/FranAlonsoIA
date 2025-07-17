//
//  GetClientsUseCase.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.07.2025.
//

import Foundation

final class GetClientsUseCase {
    private let repository: ClientRepository

    init(repository: ClientRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Client] {
        try await repository.getAllClients()
    }
}
