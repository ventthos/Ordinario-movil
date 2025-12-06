//
//  AnnoucementBoardView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct AnnouncementBoardView: View {
    
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    var primaryBackground: Color {
        if let hex = viewModel.config?.colors.background {
            return Color(hex: hex)
        }
        return Color(red: 28/255, green: 28/255, blue: 30/255)
    }
    
    var announcements: [Announcement]{
        return viewModel.config?.annoucements ?? []
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                primaryBackground.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 14) {

                        // Header moderno
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tablón de Anuncios")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)

                            Text("Lo más reciente de tu institución")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 12)

                        // No hay anuncios
                        if announcements.isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "megaphone")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white.opacity(0.5))

                                Text("Sin anuncios")
                                    .foregroundColor(.white.opacity(0.65))
                                    .font(.headline)
                            }
                            .padding(.vertical, 60)
                        } else {
                            VStack(spacing: 16) {
                                ForEach(announcements) { ann in
                                    AnnouncementCard(announcement: ann)
                                        .transition(.opacity.combined(with: .scale))
                                        .environmentObject(viewModel)
                                }
                            }
                            .padding(.top, 6)
                        }

                        Spacer(minLength: 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

struct AnnouncementBoardView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementBoardView()
        .preferredColorScheme(.dark)
        .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
    }
}
