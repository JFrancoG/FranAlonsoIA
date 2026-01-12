//
//  ClientsView.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.07.2025.
//

import SwiftUI

struct ClientsView: View {
    @Environment(AppDependencies.self) private var dependencies
    @State private var viewModel: ClientsViewModel?

    var body: some View {
        NavigationStack {
            Group {
                if let viewModel {
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
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Clients")
            .task {
                if viewModel == nil {
                    viewModel = dependencies.makeClientsViewModel()
                }
                await viewModel?.fetchClients()
            }
        }
    }
}

#Preview {
    ClientsView()
        .environment(AppDependencies.preview)
}
