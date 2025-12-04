//
//  Meal.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//
import SwiftUI

struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
    let iconName: String
    let color: Color
    let imageName: String
}
