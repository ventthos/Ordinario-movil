//
//  SubjectCardView.swift
//  ordinario
//
//  Created by user286436 on 12/2/25.
//

import SwiftUI

import Foundation



struct SubjectCardView: View {
    let subject: Subject
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    // Colores personalizados
    var cardBackgroundColor: Color {
        if let hex = viewModel.config?.colors.cardBackground {
            return Color(hex: hex)
        }
        return Color(red: 44/255, green: 44/255, blue: 46/255)
    }
    
    var accentColor: Color {
        let hex = viewModel.config?.colors.mainColor ?? "#000000"
        return Color(hex: hex)
    }
    
    var cardTextColor: Color {
        let hex = viewModel.config?.colors.cardFontColor ?? "#ffffff"
        return Color(hex: hex)
    }
    
    var body: some View {
        HStack(spacing: 15) {
            // 1. Foto de la Materia (AsyncImage)
            AsyncImage(url: URL(string: subject.photoURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipped()
                } else if phase.error != nil {
                    Image(systemName: "book.closed.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                } else {
                    ProgressView()
                        .frame(width: 55, height: 55)
                }
            }
            .background(accentColor.opacity(0.8))
            .cornerRadius(10)
            
            // 2. Información del Texto
            VStack(alignment: .leading, spacing: 4) {
                // Nombre de la Materia
                Text(subject.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(cardTextColor)
                    .lineLimit(1)
                
                // Nombre del Maestro
                Text(subject.teacherName)
                    .font(.subheadline)
                    .foregroundColor(cardTextColor.opacity(0.8))
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Icono de flecha
            Image(systemName: "chevron.right")
                .foregroundColor(cardTextColor.opacity(0.8))
        }
        .padding()
        // Contenedor con fondo oscuro que imita las tarjetas del diseño 2
        .background(cardBackgroundColor)
        .cornerRadius(15)
    }
}
