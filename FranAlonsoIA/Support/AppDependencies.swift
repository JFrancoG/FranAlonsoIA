//
//  AppDependencies.swift
//  FranAlonsoIA
//
//  Created by Codex on 12.01.2026.
//

import Observation

@Observable
final class AppDependencies {
    let clientRepository: ClientRepository
    let getClientsUseCase: GetClientsUseCase

    init(clientRepository: ClientRepository = FakeClientRepository(clients: [])) {
        self.clientRepository = clientRepository
        self.getClientsUseCase = GetClientsUseCase(repository: clientRepository)
    }

    func makeClientsViewModel() -> ClientsViewModel {
        ClientsViewModel(getClientsUseCase: getClientsUseCase)
    }
}

extension AppDependencies {
    static var preview: AppDependencies {
        let previewClients: [Client] = [
            .fake(id: "1", name: "Ana Cliente", phones: ["123456789"]),
            .fake(id: "2", name: "Luis Cliente", phones: ["987654321"])
        ]
        return AppDependencies(clientRepository: FakeClientRepository(clients: previewClients))
    }
}
