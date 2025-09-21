//
//  DesignTokens.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 20.09.2025.
//

import SwiftUI

/// Espaciados estándar
enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

/// Radio de esquinas
enum CornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let extraLarge: CGFloat = 32
}

/// Sombras comunes
enum Shadow {
    static let light = Color.black.opacity(0.05)
    static let medium = Color.black.opacity(0.1)
    static let heavy = Color.black.opacity(0.2)

    static let radius: CGFloat = 8
}

/// Líneas separadoras y bordes
enum StrokeWidth {
    static let thin: CGFloat = 1
    static let regular: CGFloat = 2
}

/// Altura mínima de componentes
enum ComponentHeight {
    static let button: CGFloat = 48
    static let textField: CGFloat = 44
}
