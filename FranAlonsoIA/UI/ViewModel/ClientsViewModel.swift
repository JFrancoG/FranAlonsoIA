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

extension ClientsViewModel {
    static var preview: ClientsViewModel {
        let vm = ClientsViewModel()
        vm.clients = [
            Client(
                id: "1",
                fullName: "Fran Alonso",
                phones: ["666123123"],
                email: "fran@example.com",
                gender: "male",
                billingAddress: nil,
                birthDate: nil,
                colorRecipe: "Rubio dorado",
                lastColorDate: nil,
                profilePhotoUrl: nil,
                consentFormUrl: nil,
                notes: "Cliente habitual",
                isActive: true
            ),
            Client(
                id: "2",
                fullName: "Lucía Gómez",
                phones: ["666888999", "666777666"],
                email: nil,
                gender: "female",
                billingAddress: nil,
                birthDate: nil,
                colorRecipe: nil,
                lastColorDate: nil,
                profilePhotoUrl: nil,
                consentFormUrl: nil,
                notes: nil,
                isActive: true
            )
        ]
        return vm
    }
}
