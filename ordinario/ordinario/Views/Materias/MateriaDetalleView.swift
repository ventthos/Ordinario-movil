//  MateriaDetalleView.swift

import SwiftUI

struct MateriaDetalleView: View {
    let materia: Subject
    let primaryBackground = Color(red: 28/255, green: 28/255, blue: 30/255)
    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255)
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)
    
    var body: some View {
        ZStack {
            primaryBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    // 📌 ENVOLVEMOS LA IMAGEN EN GEOMETRYREADER
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
                                    .frame(width: width, height: 200)  // 👈 SE BLOQUEA EL ANCHO REAL
                                    .clipped()                         // 👈 ¡NO SE SALE!

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
                    .frame(height: 200)  // 👈 IMPORTANTE para que GeometryReader no se expanda
                    .padding(.horizontal)

                    // CONTENIDO
                    VStack(alignment: .leading, spacing: 18) {

                        Text(materia.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(accentColor)
                            Text(materia.teacherName)
                                .font(.title3)
                                .foregroundColor(.white)
                        }

                        Divider().background(.white)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Horarios")
                                .font(.title2.bold())
                                .foregroundColor(.white)

                            HStack {
                                Image(systemName: "calendar")
                                Text(materia.schedule)
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .font(.subheadline)
                        }

                        Divider().background(.white)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Descripción")
                                .font(.title2.bold())
                                .foregroundColor(.white)

                            Text(materia.description)
                                .foregroundColor(.white.opacity(0.9))
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
}

