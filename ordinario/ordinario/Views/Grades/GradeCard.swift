//
//  GradeCard.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI
struct GradeCard: View {
    let grade: Grade
    
    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255)
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)

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
