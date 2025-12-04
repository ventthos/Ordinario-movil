//
//  SubjectCardView.swift
//  ordinario
//
//  Created by user286436 on 12/2/25.
//

import SwiftUI

import Foundation

/// Estructura para representar una materia.
struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let teacherName: String
    let photoURL: String // URL de la imagen de la materia
    let schedule: String
    let description: String
    
    // Datos de ejemplo
    static let sampleSubjects = [
        Subject(name: "Cálculo Integral",
                teacherName: "Dr. Alicia Ramos",
                photoURL: "https://ejemplo.com/imagenes/calculo.jpg", // Reemplaza con una URL real
                schedule: "Lun, Mié, Vie - 08:00 a 09:30",
                description: "Estudio de las integrales y sus aplicaciones en física e ingeniería."),
        
        Subject(name: "Literatura Universal",
                teacherName: "Mtra. Roberto Gómez",
                photoURL: "https://ejemplo.com/imagenes/literatura.jpg", // Reemplaza con una URL real
                schedule: "Mar, Jue - 10:00 a 12:00",
                description: "Análisis de las obras más influyentes de la literatura mundial."),
        
        Subject(name: "Programación en Swift",
                teacherName: "Ing. Sofía Pérez",
                photoURL: "https://ejemplo.com/imagenes/swift.jpg", // Reemplaza con una URL real
                schedule: "Mié, Vie - 14:00 a 16:00",
                description: "Desarrollo de aplicaciones iOS utilizando el lenguaje Swift y SwiftUI.")
    ]
}


struct SubjectCardView: View {
    let subject: Subject
    
    // Colores personalizados
    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255) // #2C2C2E
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255) // Coral (#FF5733)
    
    var body: some View {
        HStack(spacing: 15) {
            // 1. Foto de la Materia (AsyncImage)
            AsyncImage(url: URL(string: subject.photoURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                } else if phase.error != nil {
                    // Placeholder si hay error de carga
                    Image(systemName: "book.closed.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                } else {
                    // Placeholder mientras carga
                    ProgressView()
                }
            }
            .frame(width: 55, height: 55)
            .background(accentColor.opacity(0.8)) // Fondo de acento Coral
            .cornerRadius(10)
            
            // 2. Información del Texto
            VStack(alignment: .leading, spacing: 4) {
                // Nombre de la Materia
                Text(subject.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                // Nombre del Maestro
                Text(subject.teacherName)
                    .font(.subheadline)
                    .foregroundColor(.gray) // Gris claro para contraste sutil
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Icono de flecha
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        // Contenedor con fondo oscuro que imita las tarjetas del diseño 2
        .background(cardBackgroundColor)
        .cornerRadius(15)
    }
}
