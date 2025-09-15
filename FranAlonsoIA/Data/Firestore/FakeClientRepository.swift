//
//  FakeClientRepository.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.07.2025.
//

import Foundation

final class FakeClientRepository: ClientRepository {
    private let clients: [Client]

    init(clients: [Client]) {
        self.clients = clients
    }

    func getAllClients() async throws -> [Client] {
        return clients
    }
}
