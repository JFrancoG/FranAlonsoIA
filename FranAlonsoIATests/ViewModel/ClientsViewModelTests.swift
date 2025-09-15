//
//  ClientsViewModelTests.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 12.09.2025.
//


import XCTest
@testable import FranAlonsoIA

@MainActor
final class ClientsViewModelTests: XCTestCase {

    func test_fetchClients_loadsClientsSuccessfully() async {
        // Arrange
        let expectedClients = [
            Client.fake(id: "1", name: "Ana Cliente", phones: ["123456789"]),
            Client.fake(id: "2", name: "Luis Cliente", phones: ["987654321"])
        ]
        let fakeRepository = FakeClientRepository(clients: expectedClients)
        let useCase = GetClientsUseCase(repository: fakeRepository)
        let viewModel = ClientsViewModel(getClientsUseCase: useCase)

        // Act
        await viewModel.fetchClients()

        // Assert
        XCTAssertEqual(viewModel.clients.count, expectedClients.count)
        XCTAssertEqual(viewModel.clients[0].fullName, "Ana Cliente")
        XCTAssertEqual(viewModel.clients[1].phones.first, "987654321")
    }
}
