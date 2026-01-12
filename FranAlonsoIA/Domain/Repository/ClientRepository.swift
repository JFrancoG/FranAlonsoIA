//
//  ClientRepository.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.07.2025.
//

import Foundation

protocol ClientRepository {
    func getAllClients() async throws -> [Client]
    func getClient(id: String) async throws -> Client?
    func createClient(_ client: Client) async throws
    func updateClient(_ client: Client) async throws
    func deleteClient(id: String) async throws
}
