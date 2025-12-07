//
//  GradeCard.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI
struct GradeCard: View {
    let grade: Grade
    
    @EnvironmentObject var viewModelDb: DesignTokensViewModel
    var cardBackgroundColor: Color {
        if let hex = viewModelDb.config?.colors.cardBackground {
            return Color(hex: hex)
        }
        return Color(red: 44/255, green: 44/255, blue: 46/255)
    }
    
    var accentColor: Color {
        let hex = viewModelDb.config?.colors.mainColor ?? "#000000"
        return Color(hex: hex)
    }

    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                accentColor.opacity(0.9)
                Image(systemName: "bookmark.fill")
                    .foregroundColor(.white)
            }
            .frame(width: 55, height: 55)
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(grade.subjectName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Calificación: \(Int(grade.score))")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.subheadline)
            }

            Spacer()
        }
        .padding()
        .background(cardBackgroundColor)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
