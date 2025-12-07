//  MateriaDetalleView.swift

import SwiftUI

struct MateriaDetalleView: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    let materia: Subject
    
    var primaryBackground: Color {
        if let hex = viewModel.config?.colors.background {
            return Color(hex: hex)
        }
        return Color(red: 28/255, green: 28/255, blue: 30/255)
    }
    
    var mainTextColor: Color {
        let hex = viewModel.config?.colors.mainFontColor ?? "#ffffff"
        return Color(hex: hex)
    }
    
    var cardBackgroundColor: Color {
        if let hex = viewModel.config?.colors.cardBackground {
            return Color(hex: hex)
        }
        return Color(red: 44/255, green: 44/255, blue: 46/255)
    }
    
    var accentColor: Color {
        let hex = viewModel.config?.colors.mainColor ?? "#000000"
        return Color(hex: hex)
    }
    
    var cardTextColor: Color {
        let hex = viewModel.config?.colors.cardFontColor ?? "#ffffff"
        return Color(hex: hex)
    }

    
    var body: some View {
        ZStack {
            primaryBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    GeometryReader { proxy in
                        let width = proxy.size.width

                        AsyncImage(url: URL(string: materia.photoURL)) { phase in
                            switch phase {
                            case .empty:
                                ZStack {
                                    Color.gray.opacity(0.3)
                                    ProgressView()
                                }

                            case .success(let img):
                                img.resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: 200)  
                                    .clipped()

                            case .failure:
                                ZStack {
                                    Color.gray.opacity(0.3)
                                    Image(systemName: "exclamationmark.triangle")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }

                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    .frame(height: 200)
                    .padding(.horizontal)

                    // CONTENIDO
                    VStack(alignment: .leading, spacing: 18) {

                        Text(materia.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(cardTextColor)

                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(accentColor)
                            Text(materia.teacherName)
                                .font(.title3)
                                .foregroundColor(cardTextColor)
                        }

                        Divider().background(accentColor)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Horarios")
                                .font(.title2.bold())
                                .foregroundColor(cardTextColor)

                            HStack {
                                Image(systemName: "calendar")
                                Text(materia.schedule)
                                Spacer()
                            }
                            .foregroundColor(cardTextColor)
                            .font(.subheadline)
                        }

                        Divider().background(accentColor)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Descripción")
                                .font(.title2.bold())
                                .foregroundColor(cardTextColor)

                            Text(materia.description)
                                .foregroundColor(cardTextColor.opacity(0.9))
                        }

                        Divider().background(.white)

                        Button {
                            // acción
                        } label: {
                            HStack {
                                Spacer()
                                Text("Entrar a la materia")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Spacer()
                            }
                            .padding()
                            .background(accentColor)
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(cardBackgroundColor)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    MateriaDetalleView(
        materia: Subject(
            name: "Cálculo Integral",
            teacherName: "Dr. Alicia Ramos",
            photoURL: "https://store-images.s-microsoft.com/image/apps.23383.14093828725404571.e8c4fd85-da7e-4c33-9a85-c97c9f3eeb38.d4808fda-8607-464f-91cf-a9228cda620e?q=90&w=480&h=270",
            schedule: "Lun, Mié, Vie - 08:00 a 09:30",
            description: "Estudio de las integrales y sus aplicaciones."
        )
    )
    .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
}

