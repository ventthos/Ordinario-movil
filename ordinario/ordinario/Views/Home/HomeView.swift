//
//  HomeView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    // Datos dinámicos desde Firebase
    let institutionName: String
    let accentColor: Color
    let logoURL: String?
    let bannerURL: String?
    let userPhotoURL: String?
    let announcements: [Announcement]
    let menuItems: [HomeMenuItem]

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
                    AnnouncementCarousel(announcements: announcements)

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
                    .foregroundColor(.white)
                Text("Portal estudiantil")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            // Foto del alumno
            if let photoStr = userPhotoURL, let url = URL(string: photoStr) {
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
                
                NavigationLink(destination: item.destination) {
                    VStack(spacing: 14) {
                        Image(systemName: item.icon)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(item.color.opacity(0.25))
                            .clipShape(Circle())

                        Text(item.title)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.vertical, 22)
                    .frame(maxWidth: .infinity)
                    .background(card)
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
    let destination: AnyView
}

//
// MARK: - Preview
//

#Preview {
    HomeView(
        institutionName: "Instituto Tecnológico Superior",
        accentColor: Color(red: 255/255, green: 87/255, blue: 51/255),
        logoURL: "https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_TEC.png",
        bannerURL: "https://images.unsplash.com/photo-1523050854058-8df90110c9f1",
        userPhotoURL: "https://randomuser.me/api/portraits/men/32.jpg",
        announcements: [
            Announcement(
                title: "Convocatoria de Becas 2025",
                message: "Aplica antes del 10 de enero",
                date: Date(),
                imageURL: "https://images.unsplash.com/photo-1521737604893-d14cc237f11d"
            ),
            Announcement(
                title: "Nuevo Laboratorio de IA",
                message: "Inauguración muy pronto",
                date: Date(),
                imageURL: "https://images.unsplash.com/photo-1519389950473-47ba0277781c"
            )
        ],
        menuItems: [
            HomeMenuItem(title: "Cursos", icon: "book.fill", color: .blue, destination: AnyView(Text("Cursos"))),
            HomeMenuItem(title: "Tareas", icon: "checkmark.circle.fill", color: .green, destination: AnyView(Text("Tareas"))),
            HomeMenuItem(title: "Calificaciones", icon: "chart.bar.fill", color: .purple, destination: AnyView(Text("Calificaciones"))),
            HomeMenuItem(title: "Perfil", icon: "person.fill", color: .orange, destination: AnyView(Text("Perfil")))
        ]
    )
    .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
}

