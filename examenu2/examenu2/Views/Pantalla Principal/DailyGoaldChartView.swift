//
//  DailyGoaldChartView.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI
struct DailyGoalChartView: View {
    let dailyGoal = 2020.0
    
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    
    let nutrientData: [NutrientData] = [
        .init(name: "Proteins", consumed: 5.0, goal: 77.0, unit: "g"),
        .init(name: "Carbs", consumed: 20.0, goal: 94.0, unit: "g"),
        .init(name: "Fat", consumed: 2.0, goal: 12.0, unit: "g")
    ]
    
    var body: some View {
        let consumed = viewModel.config?.progresoCalorias ?? 0
        DailyGoalChart(consumed: consumed, goal: dailyGoal, nutrientData: nutrientData)
            .padding(.horizontal)
            .environmentObject(viewModel)
    }
}
