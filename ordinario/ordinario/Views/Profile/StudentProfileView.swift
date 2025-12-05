import SwiftUI

struct UserProfileView: View {
    
    // MARK: - Datos del estudiante
    let name: String
    let email: String
    let career: String
    let group: String
    let photoURL: String?
    
    // MARK: - Datos institucionales
    let institutionName: String
    let logoURL: String?
    let accent: Color
    
    // MARK: - Colores base
    let primaryBackground = Color(red: 28/255, green: 28/255, blue: 30/255)  // #1C1C1E
    let cardBackground = Color(red: 44/255, green: 44/255, blue: 46/255)     // #2C2C2E
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            primaryBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    // MARK: - HEADER INSTITUCIONAL
                    headerBanner
                    
                    // MARK: - TARJETA DE DATOS DEL ALUMNO
                    profileCard
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - HEADER INSTITUCIONAL
extension UserProfileView {
    
    private var headerBanner: some View {
        ZStack(alignment: .bottom) {
            
            // Banner con gradiente institucional
            LinearGradient(
                colors: [accent.opacity(0.6), accent.opacity(0.3), primaryBackground],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 200)
            .overlay(
                // Logo escuela opcional
                VStack {
                    if let logoStr = logoURL, let url = URL(string: logoStr) {
                        AsyncImage(url: url) { img in
                            img.resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(.top, 20)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 80)
                        }
                    }
                }
                .padding(.top)
            )
            
            // FOTO DEL USUARIO superpuesta
            VStack {
                if let urlStr = photoURL, let url = URL(string: urlStr) {
                    AsyncImage(url: url) { img in
                        img.resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(accent, lineWidth: 4)
                            )
                            .shadow(color: accent.opacity(0.6), radius: 10)
                    } placeholder: {
                        Circle()
                            .fill(accent.opacity(0.3))
                            .frame(width: 120, height: 120)
                    }
                }
            }
            .offset(y: 60)
        }
        .padding(.bottom, 70)
    }
}


// MARK: - TARJETA DE DATOS
extension UserProfileView {
    
    private var profileCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            
            Text("Información del Estudiante")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            infoRow(icon: "person.fill", title: "Nombre", value: name)
            infoRow(icon: "envelope.fill", title: "Correo", value: email)
            infoRow(icon: "graduationcap.fill", title: "Carrera", value: career)
            infoRow(icon: "person.2.fill", title: "Grupo", value: group)
            
            // MARK: - Línea decorativa animada (estilo 10)
            RoundedRectangle(cornerRadius: 4)
                .fill(accent)
                .frame(height: 6)
                .padding(.top, 8)
                .opacity(animate ? 0.45 : 1)
        }
        .padding()
        .background(cardBackground.opacity(0.9))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(accent.opacity(0.8), lineWidth: 1.5)
        )
        .cornerRadius(20)

        .padding(.horizontal)
    }
    
    // FILA DE INFO
    private func infoRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(accent)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
    }
}


// MARK: - PREVIEW
#Preview {
    UserProfileView(
        name: "Juan Pérez",
        email: "juan.perez@example.com",
        career: "Ingeniería en Sistemas",
        group: "6° A",
        photoURL: "https://i.pravatar.cc/300",
        
        institutionName: "Instituto Tecnológico Superior",
        logoURL: "https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_TEC.png",
        accent: Color(red: 255/255, green: 87/255, blue: 51/255)
    )
}

