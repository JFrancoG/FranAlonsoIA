//
//  AppointmentMapper.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 06.07.2025.
//

import Foundation

// Modelo de datos para persistencia o red
struct AppointmentDTO: Codable, Equatable {
    let id: UUID
    let clientId: UUID
    let serviceIds: [UUID]
    let date: Date
    let durationMinutes: Int
    let isConfirmed: Bool
    let notes: String?
}

// Mapper entre AppointmentDTO y Appointment del dominio
struct AppointmentMapper {
    static func toDomain(from dto: AppointmentDTO) -> Appointment {
        return Appointment(
            id: dto.id,
            clientId: dto.clientId,
            serviceIds: dto.serviceIds,
            date: dto.date,
            durationMinutes: dto.durationMinutes,
            isConfirmed: dto.isConfirmed,
            notes: dto.notes
        )
    }

    static func toDTO(from appointment: Appointment) -> AppointmentDTO {
        return AppointmentDTO(
            id: appointment.id,
            clientId: appointment.clientId,
            serviceIds: appointment.serviceIds,
            date: appointment.date,
            durationMinutes: appointment.durationMinutes,
            isConfirmed: appointment.isConfirmed,
            notes: appointment.notes
        )
    }
}
