//
//  GradesView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct GradesView: View {
    @StateObject private var viewModel = GradeViewModel()
    
    let primaryBackground = Color(red: 28/255, green: 28/255, blue: 30/255)
    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255)
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)

    var body: some View {
        NavigationView {
            ZStack {
                primaryBackground.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {

                        // TÍTULO PRINCIPAL
                        Text("Calificaciones")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top, 10)

                        // 📌 PROMEDIO GENERAL
                        VStack(spacing: 6) {
                            Text("Promedio General")
                                .foregroundColor(.white.opacity(0.7))
                            Text("\(viewModel.globalAverage, specifier: "%.2f")")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(accentColor)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(cardBackgroundColor)
                        .cornerRadius(20)
                        .padding(.horizontal)

                        // 📌 SEMESTRES
                        ForEach(viewModel.semesters, id: \.title) { semester in
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(semester.title)
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .padding(.leading)

                                ForEach(semester.grades) { grade in
                                    GradeCard(grade: grade)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    GradesView()
}
