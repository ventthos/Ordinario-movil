//
//  Platillo.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI

// Modelo para los Macros
struct MacroData: Identifiable {
    let id = UUID()
    let name: String
    let valueGrams: Double
    let percentage: Double
    let color: Color
}

// Modelo completo de la Receta
struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let imageURL: String
    let calories: Int
    let time: String     // Ej: "10 min"
    let servings: String // Ej: "Serves 5"
    
    // Macros
    let protein: MacroData
    let carbs: MacroData
    let fat: MacroData
    
    // Contenido
    let description: String
    let ingredients: [String] // Simplificado para el ejemplo
    let instructions: [String]
}
