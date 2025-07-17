//
//  ClientsView.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.07.2025.
//

import SwiftUI

struct ClientsView: View {
    @StateObject private var viewModel = ClientsViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.clients, id: \.id) { client in
                VStack(alignment: .leading) {
                    Text(client.fullName)
                        .font(.headline)
                    if let phone = client.phones.first {
                        Text(phone)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Clients")
            .onAppear {
                viewModel.fetchClients()
            }
        }
    }
}

#Preview {
    ClientsView()
}
