//
//  AnnoucementCard.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct AnnouncementCard: View {
    let announcement: Announcement

    // Colores consistentes con tu app
    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255)
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Título
            Text(announcement.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            // Mensaje (puede ocupar varias líneas)
            Text(announcement.message)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            // Fecha pequeña (si existe)
            if let d = announcement.date {
                HStack {
                    Spacer()
                    Text(d, style: .date)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .padding()
        .background(cardBackgroundColor)
        .cornerRadius(14)
        .overlay(
            // pequeño borde de acento en el lateral izquierdo
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.clear)
                .background(
                    HStack {
                        Rectangle()
                            .fill(accentColor)
                            .frame(width: 6)
                            .cornerRadius(6)
                        Spacer()
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
        )
        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
    }
}
