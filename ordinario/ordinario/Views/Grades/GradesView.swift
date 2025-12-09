//
//  GradesView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct GradesView: View {
    @StateObject private var viewModel = GradeViewModel()
    @EnvironmentObject var viewModelDb: DesignTokensViewModel
    @EnvironmentObject var session: UserSession
    var primaryBackground: Color {
        let hex = viewModelDb.config?.colors.background ?? "#141416"
        return Color(hex: hex)
    }
    
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
    
    var mainTextColor: Color {
        let hex = viewModelDb.config?.colors.mainFontColor ?? "#ffffff"
        return Color(hex: hex)
    }
    
    var cardTextColor: Color {
        let hex = viewModelDb.config?.colors.cardFontColor ?? "#ffffff"
        return Color(hex: hex)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                primaryBackground.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {

                        // TÍTULO PRINCIPAL
                        Text("Calificaciones")
                            .font(.largeTitle.bold())
                            .foregroundColor(mainTextColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top, 10)

                        // 📌 PROMEDIO GENERAL
                        VStack(spacing: 6) {
                            Text("Promedio General")
                                .foregroundColor(cardTextColor)
                            Text("\(viewModel.getGlobalAverage(semesters:session.currentUser?.grades ?? []), specifier: "%.2f")")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(accentColor)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(cardBackgroundColor)
                        .cornerRadius(20)
                        .padding(.horizontal)

                        // 📌 SEMESTRES
                        ForEach(session.currentUser?.grades ?? [], id: \.title) { semester in
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(semester.title)
                                    .font(.title2.bold())
                                    .foregroundColor(mainTextColor)
                                    .padding(.leading)

                                ForEach(semester.grades) { grade in
                                    GradeCard(grade: grade)
                                        .environmentObject(viewModelDb)
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
        .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
}
