//
//  HomeView.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 16.09.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo visual moderno
                Rectangle()
                    .fill(LinearGradient(
                        colors: [.purple.opacity(0.3), .pink.opacity(0.15)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    )
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("👋 Bienvenido, Jesús")
                            .font(.largeTitle.bold())
                            .padding(.top)

                        HStack(spacing: 16) {
                            QuickActionButton(title: "Nuevo Cliente", systemImage: "person.badge.plus")
                            QuickActionButton(title: "Añadir Cita", systemImage: "calendar.badge.plus")
                        }

                        Text("Resumen de hoy")
                            .font(.title2.bold())

                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .frame(height: 150)
                            .overlay(Text("Aquí irán las estadísticas").foregroundStyle(.primary))

                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .navigationTitle("Inicio")
        }
    }
}

private struct QuickActionButton: View {
    var title: String
    var systemImage: String

    var body: some View {
        Button {
            // Acción a definir
        } label: {
            Label(title, systemImage: systemImage)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
}
