//
//  HomeView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    @EnvironmentObject var session: UserSession
    @Binding var selectedTab: Int
    
    var menuItems: [HomeMenuItem] {
        [
            HomeMenuItem(title: "Cursos", icon: "book.fill", color: Color(hex:viewModel.config?.colors.subjectsColor ?? "#ffffff") , tab:1),
            HomeMenuItem(title: "Tareas", icon: "checkmark.circle.fill", color: Color(hex:viewModel.config?.colors.tasksColor ?? "#ffffff"), tab: 2),
            HomeMenuItem(title: "Calificaciones", icon: "chart.bar.fill", color: Color(hex:viewModel.config?.colors.gradesColor ?? "#ffffff"), tab: 2),
            HomeMenuItem(title: "Perfil", icon: "person.fill", color: Color(hex:viewModel.config?.colors.announcementsColor ?? "#ffffff"), tab: 3)
        ]
    }

    var bg: Color {
        let hex = viewModel.config?.colors.background ?? "#141416"
        return Color(hex: hex)
    }
    
    var card: Color {
        if let hex = viewModel.config?.colors.cardBackground {
            return Color(hex: hex)
        }
        return Color(red: 44/255, green: 44/255, blue: 46/255)
    }
    
    var annoucements: [Announcement]{
        return viewModel.config?.annoucements ?? []
    }
    
    var accentColor: Color {
        let hex = viewModel.config?.colors.mainColor ?? "#000000"
        return Color(hex: hex)
    }

    @State private var animate = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // Header institucional + foto de usuario
                    headerSection

                    // Banner institucional
                    bannerSection

                    // Carrusel de promociones / avisos
                    AnnouncementCarousel(announcements: Array(annoucements.suffix(4)).reversed())
                        .environmentObject(viewModel)

                    // Menú principal
                    quickMenu
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .background(bg.ignoresSafeArea())
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                animate = true
            }
        }
        .preferredColorScheme(.dark)
    }
}

//
// MARK: - Secciones
//

extension HomeView {

    // HEADER con logo + nombre institución + foto usuario
    private var headerSection: some View {
        HStack {

            // Logo
            if let urlStr = viewModel.config?.values.logoUrl, let url = URL(string: urlStr) {
                AsyncImage(url: url) { img in
                    img.resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.config?.strings.nombreInstitucion ?? "")
                    .font(.headline)
                    .foregroundColor(Color(hex: viewModel.config?.colors.mainFontColor ?? "#ffffff"))
            }

            Spacer()

            // Foto del alumno
            if let photoStr = session.currentUser?.photoUrl, let url = URL(string: photoStr) {
                AsyncImage(url: url) { img in
                    img.resizable()
                        .scaledToFill()
                        .frame(width: 42, height: 42)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(accentColor, lineWidth: 2)
                        )
                } placeholder: {
                    Circle()
                        .fill(accentColor.opacity(0.4))
                        .frame(width: 42, height: 42)
                }
            }
        }
        .padding(.top, 10)
    }

    // BANNER institucional
    private var bannerSection: some View {
        VStack {
            Text(viewModel.config?.strings.greeting ?? "")
                .font(.title3)
                .foregroundColor(Color(hex: viewModel.config?.colors.mainFontColor ?? "#ffffff"))
                .fontWeight(.bold)
            if let urlStr = viewModel.config?.values.bannerImageUrl, let url = URL(string: urlStr) {
                AsyncImage(url: url) { img in
                    img.resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                        .cornerRadius(18)
                        .shadow(radius: 10)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(accentColor.opacity(0.25))
                        .frame(height: 150)
                }
            }
        }
    }

    // GRID de menú principal
    private var quickMenu: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                  spacing: 16) {
            ForEach(menuItems) { item in
                
                Button{
                    selectedTab = item.tab
                } label:{
                    VStack(spacing: 14) {
                        Image(systemName: item.icon)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(item.color.opacity(0.8))
                            .clipShape(Circle())

                        Text(item.title)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.vertical, 22)
                    .frame(maxWidth: .infinity)
                    .background(item.color.opacity(0.6))
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.3), radius: 6, y: 3)
                    .scaleEffect(animate ? 1 : 0.94)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

//
// MARK: - Modelo HomeMenuItem
//

struct HomeMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let tab: Int
}


