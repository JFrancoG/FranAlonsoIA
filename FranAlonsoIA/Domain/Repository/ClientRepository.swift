//
//  ClientRepository.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.07.2025.
//

import Foundation

protocol ClientRepository {
    func getAllClients() async throws -> [Client]
}
