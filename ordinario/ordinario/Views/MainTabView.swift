//
//  MainTabView.swift
//  ordinario
//
//  Created by user286436 on 12/4/25.
//


import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    var accentColor: Color {
        let hex = viewModel.config?.colors.mainColor ?? "#000000"
        return Color(hex: hex)
    }
    
    // Para saber en qué tab estamos
    @State private var selectedTab: Int = 0
    
    init() {
            // Fondo de la TabBar
            UITabBar.appearance().backgroundColor = UIColor.black
            UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
        }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
                .tag(0)
                .environmentObject(viewModel)
            
            SubjectListView()
                .tabItem{
                    Image(systemName: "book")
                    Text("Materias")
                }
                .tag(1)
                .environmentObject(viewModel)
            
            GradesView()
                .tabItem{
                    Image(systemName: "book.closed.fill")
                    Text("Calificaciones")
                }
                .tag(2)
                .environmentObject(viewModel)
            AnnouncementBoardView()
                .tabItem{
                    Image(systemName: "megaphone.fill")
                    Text("Anuncios")
                }
                .tag(3)
                .environmentObject(viewModel)
            UserProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Anuncios")
                }
                .tag(4)
                .environmentObject(viewModel)
        }
        .tint(accentColor)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainTabView()
        .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
}
