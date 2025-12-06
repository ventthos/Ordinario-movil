import SwiftUI

struct AnnouncementCard: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    let announcement: Announcement

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
    
    var mainFontColor: Color {
        let hex = viewModel.config?.colors.mainFontColor ?? "#ffffff"
        return Color(hex: hex)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // Imagen del anuncio
            if let urlString = announcement.imageURL,
               let url = URL(string: urlString) {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
                        Color.gray.opacity(0.3)
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.white.opacity(0.6))
                                    .font(.largeTitle)
                            )
                            .cornerRadius(12)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            // Título
            Text(announcement.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(mainFontColor)
                .lineLimit(2)

            // Mensaje
            Text(announcement.message)
                .font(.subheadline)
                .foregroundColor(mainFontColor.opacity(0.9))

            // Fecha
            if let d = announcement.date {
                HStack {
                    Spacer()
                    Text(d, style: .date)
                        .font(.caption)
                        .foregroundColor(mainFontColor.opacity(0.6))
                }
            }
        }
        .padding()
        .background(cardBackgroundColor)
        .cornerRadius(16)
        .overlay(
            HStack {
                Rectangle()
                    .fill(accentColor)
                    .frame(width: 6)
                Spacer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        )
        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
    }
}

