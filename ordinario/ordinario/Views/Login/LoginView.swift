import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = DesignTokensViewModel(tokenProvider: FirebaseTokenProvider())
    
    // MARK: - Campos
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var background: Color {
        if let hex = viewModel.config?.colors.background {
            return Color(hex: hex)
        }
        return Color(red: 28/255, green: 28/255, blue: 30/255)
    }
    
    var cardBackground: Color {
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
        ZStack {
            background.ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                // MARK: - LOGO
                VStack {
                    if let logoStr = viewModel.config?.values.logoUrl, let url = URL(string: logoStr) {
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
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.red)
                                    .frame(height: 80)
                                    .symbolRenderingMode(.hierarchical)
                            default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(height: 80)
                            .symbolRenderingMode(.hierarchical)
                    }
                }
                .padding(.top, 40)
                
                // MARK: - TEXTOS INSTITUCIONALES
                VStack(spacing: 6) {
                    Text(viewModel.config?.strings.nombreInstitucion ?? "No data")
                        .font(.title.bold())
                        .foregroundColor(mainFontColor)
                    
                    Text("Iniciar sesión en tu cuenta")
                        .foregroundColor(mainFontColor.opacity(0.7))
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
    LoginView()
}


