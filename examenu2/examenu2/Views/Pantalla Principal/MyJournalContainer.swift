//
//  MyJournalContainer.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI

struct MyJournalContainer: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    let meals: [Recipe] = [
        
        Recipe(
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
        ),
        
        Recipe(
            name: "Beef Stir Fry",
            imageURL: "https://www.allrecipes.com/thmb/7N-Xq1XMMJw8G0KJv2e0ETUYB2I=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/228823-quick-beef-stir-fry-DDMFS-4x3-1f79b031d3134f02ac27d79e967dfef5.jpg",
            calories: 530,
            time: "20 min",
            servings: "Serves 3",
            protein: MacroData(name: "Protein", valueGrams: 40, percentage: 35, color: .green),
            carbs: MacroData(name: "Carbs", valueGrams: 45, percentage: 40, color: .blue),
            fat: MacroData(name: "Fat", valueGrams: 22, percentage: 25, color: .yellow),
            description: "A flavorful beef stir fry with colorful vegetables and soy-based sauce.",
            ingredients: [
                "300g beef strips",
                "Bell peppers",
                "Broccoli",
                "Soy sauce",
                "Garlic"
            ],
            instructions: [
                "Slice vegetables.",
                "Stir fry beef in hot oil.",
                "Add vegetables and cook 5 minutes.",
                "Add soy sauce and garlic.",
                "Serve hot."
            ]
        )
    ]

    
    var body: some View {
            // Asegúrate de que en alguna vista superior (como DailySummaryView o App entry point)
            // exista un NavigationStack o NavigationView. Si no, envuélvelo aquí.

                VStack(spacing: 15) {
                    HStack {
                        Text(viewModel.config?.journal ?? "Journalist").font(.title2).fontWeight(.bold)
                        Spacer()
                        Image("MenuIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color(hex: "#f5f5f7"))
                            .clipShape(Circle())
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 6) {
                        ForEach(meals) { meal in
                            NavigationLink(destination: RecipeDetailView(recipe: meal).environmentObject(viewModel)) {
                                MealCardView(meal: meal)
                                    .environmentObject(viewModel)
                            }
                            .buttonStyle(PlainButtonStyle()) // Para que no cambie el color de la tarjeta
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .background(Color(hex:viewModel.config?.bg_body ?? "#000000"))
                .clipShape(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                )

        }
        
        // Función auxiliar para crear los datos detallados falsos (mock) basados en la Meal básica
        // Esto es necesario porque tu modelo Meal no tiene macros ni ingredientes
        func convertMealToRecipe(_ meal: Meal) -> Recipe {
            return Recipe(
                name: meal.name,
                imageURL: meal.imageName,
                calories: meal.calories,
                time: "10 min",
                servings: "Serves 5",
                protein: MacroData(name: "Protein", valueGrams: 8, percentage: 9, color: .pink),
                carbs: MacroData(name: "Carbs", valueGrams: 45, percentage: 13, color: .green),
                fat: MacroData(name: "Fat", valueGrams: 23.2, percentage: 78, color: .orange),
                description: "Transform your culinary moments into a savory experience with this classic Italian dish. Creamy, peppery, and absolutely delicious.",
                ingredients: ["Pasta", "Eggs", "Pancetta", "Parmesan"],
                instructions: ["Boil pasta", "Fry pancetta", "Mix eggs and cheese", "Combine"]
            )
        }
    }
