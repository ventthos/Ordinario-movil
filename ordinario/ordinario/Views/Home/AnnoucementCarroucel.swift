//
//  AnnoucementCarroucel.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI
struct AnnouncementCarousel: View {

    let announcements: [Announcement]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Promociones / Avisos")
                .font(.headline)
                .foregroundColor(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {

                    ForEach(announcements) { ann in

                        ZStack(alignment: .bottomLeading) {

                            // Imagen
                            if let imgStr = ann.imageURL,
                               let url = URL(string: imgStr) {

                                AsyncImage(url: url) { img in
                                    img.resizable()
                                        .scaledToFill()
                                        .frame(width: 260, height: 150)
                                        .clipped()
                                } placeholder: {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(width: 260, height: 150)
                                }
                            }

                            // Degradado
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.clear,
                                    Color.black.opacity(0.85)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .cornerRadius(16)

                            // Título
                            Text(ann.title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .shadow(radius: 6)
                        }
                        .frame(width: 260, height: 150)
                        .cornerRadius(16)
                        .shadow(radius: 6)
                    }
                }
                .padding(.top, 6)
            }
        }
        .padding(.top, 10)
    }
}
