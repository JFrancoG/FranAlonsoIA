//
//  ClientsViewModel.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.07.2025.
//


import Foundation

@MainActor
final class ClientsViewModel: ObservableObject {
    @Published var clients: [Client] = []

    private let getClientsUseCase: GetClientsUseCase

    init() {
        let repository = FakeClientRepository()
        self.getClientsUseCase = GetClientsUseCase(repository: repository)
    }

    func fetchClients() {
        Task {
            do {
                let result = try await getClientsUseCase.execute()
                self.clients = result
            } catch {
                print("Error fetching clients: \(error)")
            }
        }
    }
}
