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

    init(getClientsUseCase: GetClientsUseCase) {
        self.getClientsUseCase = getClientsUseCase
    }

    func fetchClients() async {
        do {
            let result = try await getClientsUseCase.execute()
            self.clients = result
        } catch {
            print("Error fetching clients: \(error)")
        }
    }
}

extension ClientsViewModel {
    static var preview: ClientsViewModel {
        let previewClients: [Client] = [
            .fake(id: "1", name: "Ana Cliente", phones: ["123456789"]),
            .fake(id: "2", name: "Luis Cliente", phones: ["987654321"])
        ]
        let useCase = GetClientsUseCase(repository: FakeClientRepository(clients: previewClients))
        return ClientsViewModel(getClientsUseCase: useCase)
    }
}
