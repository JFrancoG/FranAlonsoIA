//
//  FakeClientRepository.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.07.2025.
//

import Foundation

final class FakeClientRepository: ClientRepository {
    private var clients: [Client]

    init(clients: [Client]) {
        self.clients = clients
    }

    func getAllClients() async throws -> [Client] {
        return clients
    }

    func getClient(id: String) async throws -> Client? {
        clients.first { $0.id == id }
    }

    func createClient(_ client: Client) async throws {
        clients.append(client)
    }

    func updateClient(_ client: Client) async throws {
        guard let index = clients.firstIndex(where: { $0.id == client.id }) else {
            return
        }
        clients[index] = client
    }

    func deleteClient(id: String) async throws {
        clients.removeAll { $0.id == id }
    }
}
