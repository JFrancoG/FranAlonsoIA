//
//  Appointment.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

struct Appointment: Identifiable, Codable, Equatable {
    let id: UUID
    let clientId: UUID
    let serviceIds: [UUID]
    let date: Date
    let durationMinutes: Int
    let isConfirmed: Bool
    let notes: String?

    init(
        id: UUID = UUID(),
        clientId: UUID,
        serviceIds: [UUID],
        date: Date,
        durationMinutes: Int,
        isConfirmed: Bool = false,
        notes: String? = nil
    ) {
        self.id = id
        self.clientId = clientId
        self.serviceIds = serviceIds
        self.date = date
        self.durationMinutes = durationMinutes
        self.isConfirmed = isConfirmed
        self.notes = notes
    }
}
