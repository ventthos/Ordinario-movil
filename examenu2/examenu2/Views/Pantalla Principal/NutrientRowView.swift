//
//  NutrientRowView.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI
struct NutrientRowView: View {
    let name: String
    let consumed: Double
    let goal: Double
    let color: Color
    let unit: String
    let accentColor: Color
    let fontColor:Color
    
    var body: some View {
        let progress = consumed / goal
        
        VStack(alignment: .leading, spacing: 2) {
            // Nombre y Valores
            HStack (spacing: 10){
                Text(name)
                    .font(.footnote)
                    .foregroundColor(fontColor.opacity(0.8))
                
                Spacer()
                
                HStack(spacing: 0){
                    Text("\(Int(consumed)) ")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(fontColor)
                    Text("/\(Int(goal))\(unit)")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(fontColor.opacity(0.8))
                }
                
            }
            
            // Barra de Progreso Horizontal Pequeña
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(accentColor)
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(min(progress, 1)), height: 6)
                        .cornerRadius(3)
                }
            }
            .frame(height: 6)
        }
    }
}
