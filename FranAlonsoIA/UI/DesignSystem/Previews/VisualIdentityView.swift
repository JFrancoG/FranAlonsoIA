//
//  VisualIdentityView.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.09.2025.
//

import SwiftUI

struct VisualIdentityView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Typography Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Typography")
                        .font(.title.bold())
                    Text("Title - 32pt").font(.interTitle)
                    Text("Subtitle - 24pt").font(.interSubtitle)
                    Text("Body - 17pt").font(.interBody)
                    Text("Caption - 13pt").font(.interCaption).foregroundColor(.secondary)
                }
                // Colors Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Colors").font(.title.bold())
                    ColorSample(name: "Background Light", color: .background)
                    ColorSample(name: "Surface Light", color: .backgroundSec)
                    ColorSample(name: "Text Primary", color: .text)
                    ColorSample(name: "Text Secondary", color: .textSec)
                    ColorSample(name: "Accent (Lavender)", color: .accentColor)
                    ColorSample(name: "Accent Alt (Blue)", color: .accentAltColor)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ColorSample: View {
    let name: String
    let color: Color

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 40, height: 40)
            Text(name)
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview("Light") {
    VisualIdentityView()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    VisualIdentityView()
        .preferredColorScheme(.dark)
}
