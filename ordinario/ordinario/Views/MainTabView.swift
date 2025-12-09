//
//  MainTabView.swift
//  ordinario
//
//  Created by user286436 on 12/4/25.
//


import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    @EnvironmentObject var session: UserSession
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
                .environmentObject(session)
            
            SubjectListView()
                .tabItem{
                    Image(systemName: "book")
                    Text("Materias")
                }
                .tag(1)
                .environmentObject(viewModel)
                .environmentObject(session)
            GradesView()
                .tabItem{
                    Image(systemName: "book.closed.fill")
                    Text("Calificaciones")
                }
                .tag(2)
                .environmentObject(viewModel)
                .environmentObject(session)
            AnnouncementBoardView()
                .tabItem{
                    Image(systemName: "megaphone.fill")
                    Text("Anuncios")
                }
                .tag(3)
                .environmentObject(viewModel)
                .environmentObject(session)
            UserProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
                .tag(4).environmentObject(session)
                .environmentObject(viewModel)
            if let user = session.currentUser {
                TasksView().tabItem {
                    Image(systemName: "checklist")
                    Text("Tareas")
                }
                .tag(5)
                .environmentObject(viewModel)
                .environmentObject(session)
            }
                
        }
        .tint(accentColor)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainTabView()
        .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
}
