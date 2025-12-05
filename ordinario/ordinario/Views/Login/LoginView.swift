import SwiftUI

struct LoginView: View {
    
    // MARK: - Datos dinámicos (Firebase los llenará)
    let logoURL: String?
    let institutionName: String
    let accentColor: Color
    
    // MARK: - Campos
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    let background = Color(red: 28/255, green: 28/255, blue: 30/255)
    let cardBackground = Color(red: 44/255, green: 44/255, blue: 46/255)
    
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                // MARK: - LOGO
                VStack {
                    if let logoStr = logoURL, let url = URL(string: logoStr) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let img):
                                img.resizable()
                                    .scaledToFit()
                                    .frame(height: 90)
                            case .empty:
                                ProgressView()
                                    .frame(height: 90)
                            case .failure:
                                Image(systemName: "building.columns")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(accentColor)
                                    .frame(height: 80)
                            default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "building.columns")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(accentColor)
                            .frame(height: 80)
                    }
                }
                .padding(.top, 40)
                
                // MARK: - TEXTOS INSTITUCIONALES
                VStack(spacing: 6) {
                    Text(institutionName)
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Text("Iniciar sesión en tu cuenta")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.headline)
                }
                
                // MARK: - CARD DE LOGIN
                VStack(spacing: 20) {
                    
                    // EMAIL
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Correo Institucional")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        TextField("ejemplo@mail.com", text: $email)
                            .padding()
                            .background(cardBackground)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    
                    // PASSWORD
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Contraseña")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        HStack {
                            Group {
                                if isPasswordVisible {
                                    TextField("•••••••", text: $password)
                                } else {
                                    SecureField("•••••••", text: $password)
                                }
                            }
                            .foregroundColor(.white)
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(cardBackground)
                        .cornerRadius(12)
                    }
                    
                    // RECUPERAR
                    Button {
                        // Acción tuya
                    } label: {
                        Text("¿Olvidaste tu contraseña?")
                            .font(.subheadline)
                            .foregroundColor(accentColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .padding()
                .background(cardBackground.opacity(0.4))
                .cornerRadius(20)
                .padding(.horizontal)
                
                // MARK: - BOTÓN LOGIN
                Button {
                    // Aquí haces Firebase Auth
                } label: {
                    HStack {
                        Spacer()
                        Text("Ingresar")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .background(accentColor)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView(
        logoURL: "https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_TEC.png",
        institutionName: "Instituto Tecnológico Superior",
        accentColor: Color(red: 255/255, green: 87/255, blue: 51/255)
    )
}

