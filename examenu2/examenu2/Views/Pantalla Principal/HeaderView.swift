//
//  HeaderView.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI

struct HeaderView: View {
    // URL de ejemplo del avatar
    
    @EnvironmentObject var viewModel: DesignTokensViewModel
    let avatarURL: String
    
    var body: some View {
        HStack {
            // Avatar con AsyncImage
            AsyncImage(url: URL(string: avatarURL)) { phase in
                switch phase {
                case .empty:
                    // Placeholder mientras carga
                    ZStack {
                        Color.gray.opacity(0.3)
                        ProgressView()
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                case .failure(_):
                    // Imagen de error
                    ZStack {
                        Color.red.opacity(0.3)
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }

            Spacer()

            // Selector de fecha
            HStack(spacing: 20) {
                Button(action: {}) { Image(systemName: "chevron.left").foregroundColor(.black) }
                HStack(spacing: 8){
                    Image("calendar")
                        .resizable()
                        .scaledToFit()     
                        .frame(width: 20, height: 20)
                    Text(viewModel.config?.calendarText ?? "Hoy")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                
                Button(action: {}) { Image(systemName: "chevron.right").foregroundColor(.black) }
            }
            .padding(.horizontal)

            Spacer()

            // Notificaciones
            Image(systemName: "bell.fill")
                .foregroundColor(Color(red: 0.58, green: 0.40, blue: 0.90))
        }
        .padding(.horizontal)
    }
}
