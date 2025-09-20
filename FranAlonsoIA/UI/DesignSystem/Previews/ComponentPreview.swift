//
//  ComponentPreview.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.09.2025.
//

import SwiftUI

struct ComponentPreview: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Buttons").font(.title.bold())
                    Button("Primary Button") {}
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    Button("Secondary Button") {}
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.backgroundSec)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Client Info Card").font(.title.bold())
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Name: Marta Sánchez").font(.headline)
                        Text("Service: Haircut + Color").font(.subheadline)
                        Text("Total: 42 €").font(.subheadline)
                    }
                    .padding()
                    .background(Color.background)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Text Field").font(.title.bold())
                    TextField("Enter client name", text: .constant(""))
                        .padding()
                        .background(Color.backgroundSec)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview("Light") {
    ComponentPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ComponentPreview()
        .preferredColorScheme(.dark)
}
