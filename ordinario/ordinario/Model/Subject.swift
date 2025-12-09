//
//  Subject.swift
//  ordinario
//
//  Created by user286436 on 12/6/25.
//

import Foundation
struct Subject: Identifiable, Equatable, Codable {
    var id = UUID()
    let name: String
    let teacherName: String
    let photoURL: String // URL de la imagen de la materia
    let schedule: String
    var tasks: [TaskItem] = []
    let description: String
    
    // Datos de ejemplo
    static let sampleSubjects = [
        Subject(name: "Cálculo Integral",
                teacherName: "Dr. Alicia Ramos",
                photoURL: "https://ejemplo.com/imagenes/calculo.jpg",
                schedule: "Lun, Mié, Vie - 08:00 a 09:30",
                description: "Estudio de las integrales y sus aplicaciones en física e ingeniería."),
        
        Subject(name: "Literatura Universal",
                teacherName: "Mtra. Roberto Gómez",
                photoURL: "https://ejemplo.com/imagenes/literatura.jpg",
                schedule: "Mar, Jue - 10:00 a 12:00",
                description: "Análisis de las obras más influyentes de la literatura mundial."),
        
        Subject(name: "Programación en Swift",
                teacherName: "Ing. Sofía Pérez",
                photoURL: "https://ejemplo.com/imagenes/swift.jpg",
                schedule: "Mié, Vie - 14:00 a 16:00",
                description: "Desarrollo de aplicaciones iOS utilizando el lenguaje Swift y SwiftUI.")
    ]
}
