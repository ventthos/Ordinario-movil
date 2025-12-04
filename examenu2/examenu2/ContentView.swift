//
//  ContentView.swift
//  examenu2
//
//  Created by user286436 on 11/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @StateObject private var viewModel = DesignTokensViewModel(tokenProvider: FirebaseTokenProvider())
    var meal = Recipe(
        name: "Chicken Caesar Salad",
        imageURL: "https://images.unsplash.com/photo-1551183053-bf91a1d81141",
        calories: 420,
        time: "15 min",
        servings: "Serves 2",
        protein: MacroData(name: "Protein", valueGrams: 32, percentage: 30, color: .green),
        carbs: MacroData(name: "Carbs", valueGrams: 20, percentage: 20, color: .blue),
        fat: MacroData(name: "Fat", valueGrams: 18, percentage: 50, color: .yellow),
        description: "Classic chicken caesar salad with crunchy lettuce, grilled chicken, parmesan cheese and creamy dressing.",
        ingredients: [
            "2 cups romaine lettuce",
            "150g grilled chicken",
            "Parmesan cheese",
            "Croutons",
            "Caesar dressing"
        ],
        instructions: [
            "Wash and chop lettuce.",
            "Grill chicken and slice.",
            "Mix lettuce with dressing.",
            "Add chicken, parmesan and croutons.",
            "Serve immediately."
        ]
    )
    
    var body: some View {
        VStack(spacing: 0) {
            // Contenido según pestaña
            ZStack {
                switch selectedTab {
                case 0: DailySummaryView()
                        .environmentObject(viewModel)
                case 1: Text("Profile Screen")
                case 2: Text("Add Screen")
                case 3: RecipeDetailView(recipe: meal)
                        .environmentObject(viewModel)
                case 4: Text("Chart Screen")
                default: Text("Home Screen")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Barra de navegación personalizada
            BottomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ContentView()
}
