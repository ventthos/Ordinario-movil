//
//  DailyGoalChart.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI

struct DailyGoalChart: View {
    let consumed: Double
    let goal: Double
    let nutrientData: [NutrientData]
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    
    var body: some View {
        let progress = min(consumed / goal, 1)
        
        let primaryColor = Color(hex:viewModel.config?.chartsAccentColor ?? "#6A5ACD")
        
        // Define el arco abierto
        let arcStart: CGFloat = 0.15
        let arcEnd: CGFloat = 0.85
        let arcRange = arcEnd - arcStart
        let actualProgress = arcStart + (progress * arcRange)
        
        HStack(alignment: .center) { // Alineación horizontal para el círculo y la leyenda
            
            // 1. Gráfico Circular (Arco Cortado con Bordes Rectos)
            ZStack {
                // Círculo de fondo (Arco gris/morado claro)
                Circle()
                    .trim(from: arcStart, to: arcEnd)
                    .stroke(primaryColor.opacity(1), lineWidth: 15)
                    .rotationEffect(.degrees(90))
                    .frame(width: 140, height: 140)
                
                // Arco de progreso (Bordes Rectos: lineCap: .butt)
                Circle()
                    .trim(from: arcStart, to: actualProgress)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 15, lineCap: .butt))
                    .rotationEffect(.degrees(90))
                    .frame(width: 140, height: 140)
                
                // Texto de calorías
                VStack {
                    Text("\(Int(consumed))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex:viewModel.config?.chartsfontcolor ?? "#ffffff"))
                    Text("🔥\(Int(goal)) kcal left")
                        .font(.caption)
                        .foregroundColor(Color(hex:viewModel.config?.chartsfontcolor ?? "#ffffff"))
                }
            }
            .padding(10)
            
            // 2. Leyenda y Barras de Nutrientes (Al lado del círculo)
            VStack(alignment: .leading, spacing: 10) {
                NutrientRowView(
                    name: nutrientData[0].name,
                    consumed: nutrientData[0].consumed,
                    goal: nutrientData[0].goal,
                    color: Color(hex:viewModel.config?.proteinscolor ?? "#6A5ACD"),
                    unit: nutrientData[0].unit,
                    accentColor: primaryColor,
                    fontColor: Color(hex:viewModel.config?.chartsfontcolor ?? "#ffffff")
                )
                NutrientRowView(
                    name: nutrientData[0].name,
                    consumed: nutrientData[1].consumed,
                    goal: nutrientData[1].goal,
                    color: Color(hex:viewModel.config?.carbscolor ?? "#6A5ACD"),
                    unit: nutrientData[1].unit,
                    accentColor: primaryColor,
                    fontColor: Color(hex:viewModel.config?.chartsfontcolor ?? "#ffffff")
                )
                NutrientRowView(
                    name: nutrientData[0].name,
                    consumed: nutrientData[2].consumed,
                    goal: nutrientData[2].goal,
                    color: Color(hex:viewModel.config?.fatscolor ?? "#6A5ACD"),
                    unit: nutrientData[2].unit,
                    accentColor: primaryColor,
                    fontColor: Color(hex:viewModel.config?.chartsfontcolor ?? "#ffffff")
                )
            }
            // Asegura que la Leyenda ocupe el espacio restante
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 10)   // padding arriba y abajo
        .padding(.horizontal, 16)
        .background(Color(hex: viewModel.config?.chartsbackgroundcolor ?? "#8279e4"))
        .cornerRadius(20)
        
    }
}
