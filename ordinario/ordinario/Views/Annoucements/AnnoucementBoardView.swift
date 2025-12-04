//
//  AnnoucementBoardView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct AnnouncementBoardView: View {
    @State var announcements: [Announcement]

    let primaryBackground = Color(red: 28/255, green: 28/255, blue: 30/255)

    var body: some View {
        NavigationView {
            ZStack {
                primaryBackground.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 14) {
                        // Título grande (igual estilo)
                        Text("Tablón de Anuncios")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top, 12)
                            .foregroundColor(.white)

                        // Si no hay anuncios mostramos un placeholder
                        if announcements.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "megaphone")
                                    .font(.largeTitle)
                                    .foregroundColor(.white.opacity(0.7))
                                Text("Sin anuncios")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            // Lista de tarjetas
                            VStack(spacing: 12) {
                                ForEach(announcements) { ann in
                                    AnnouncementCard(announcement: ann)
                                }
                            }
                            .padding(.top, 6)
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

struct AnnouncementBoardView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementBoardView(announcements: [
            Announcement(
                title: "Inicio de periodo",
                message: "El periodo ordinario comenzará el lunes 8 de diciembre. Revisen el calendario y las aulas asignadas.",
                date: Date()
            ),
            Announcement(
                title: "Entrega de proyecto",
                message: "Recuerden entregar el proyecto final en formato PDF a través de la plataforma antes de las 23:59 del viernes.",
                date: Date().addingTimeInterval(-86400)
            ),
            Announcement(
                title: "Horario de tutorías",
                message: "Las tutorías con los profesores estarán disponibles martes y jueves de 16:00 a 18:00 en el aula 204.",
                date: nil
            )
        ])
    }
}
