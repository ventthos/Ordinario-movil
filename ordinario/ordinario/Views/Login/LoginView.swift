import SwiftUI

struct LoginView: View {
    // 1. Instanciamos el Session Manager
    @ObservedObject var session = UserSession.shared
    @StateObject private var viewModel = DesignTokensViewModel(tokenProvider: FirebaseTokenProvider())
    
    // MARK: - Campos
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    // Estados para manejar errores y navegación
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false // Úsalo para navegar o cerrar el modal
    
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
        // Envolvemos en NavigationView si quieres navegar, o simplemente ZStack
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
                                ProgressView().frame(height: 90)
                            case .failure:
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .resizable().scaledToFit()
                                    .foregroundColor(.red).frame(height: 80)
                            default: EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable().scaledToFit()
                            .foregroundColor(.red).frame(height: 80)
                    }
                }
                .padding(.top, 40)
                
                // MARK: - TEXTOS INSTITUCIONALES
                VStack(spacing: 6) {
                    Text(viewModel.config?.strings.nombreInstitucion ?? "Cargando...")
                        .font(.title.bold())
                        .foregroundColor(mainFontColor)
                        .multilineTextAlignment(.center)
                    
                    Text(viewModel.config?.strings.greeting ?? "Iniciar sesión")
                        .foregroundColor(mainFontColor.opacity(0.7))
                        .font(.headline)
                }
                
                // MARK: - CARD DE LOGIN
                VStack(spacing: 20) {
                    
                    // EMAIL
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Correo Institucional")
                            .foregroundColor(Color(hex:viewModel.config?.colors.labelInputColor ?? "#ffffff"))
                            .font(.subheadline)
                        
                        TextField("oscar@gmail.com", text: $email)
                            .padding()
                            .background(Color(hex:viewModel.config?.colors.inputColor ?? "#ffffff"))
                            .cornerRadius(12)
                            .foregroundColor(Color(hex:viewModel.config?.colors.mainFontColor ?? "#ffffff"))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never) 
                            .autocorrectionDisabled(true)
                    }
                    
                    // PASSWORD
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Contraseña")
                            .foregroundColor(Color(hex:viewModel.config?.colors.labelInputColor ?? "#ffffff"))
                            .font(.subheadline)
                        
                        HStack {
                            Group {
                                if isPasswordVisible {
                                    TextField("•••••••", text: $password)
                                } else {
                                    SecureField("•••••••", text: $password)
                                }
                            }
                            .foregroundColor(Color(hex:viewModel.config?.colors.labelInputColor ?? "#ffffff"))
                            
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(hex:viewModel.config?.colors.inputColor ?? "#ffffff"))
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
                .background(cardBackground.opacity(0.9)) // Subí la opacidad para legibilidad
                .cornerRadius(20)
                .padding(.horizontal)
                
                // MARK: - BOTÓN LOGIN LÓGICA
                Button {
                    attemptLogin()
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
        // Alerta de error
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        // Navegación cuando el login es exitoso
        .fullScreenCover(isPresented: $isLoggedIn) {
            MainTabView()
                .environmentObject(session)
                .environmentObject(viewModel)
        }
    }
    
    // MARK: - LÓGICA DE LOGIN
    func attemptLogin() {
        // 1. Validar que tengamos datos cargados
        guard let usersList = viewModel.config?.userData else {
            alertMessage = "Cargando datos de la institución, intenta en un momento."
            showAlert = true
            return
        }

        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespaces)
        let passwordTrim = password.trimmingCharacters(in: .whitespaces)

        // 2. Buscar usuario por correo Y contraseña
        if let foundUser = usersList.first(where: {
            $0.email.lowercased() == normalizedEmail &&
            $0.password == passwordTrim        // 👈 Validación real de contraseña
        }) {

            // 3. Iniciar sesión
            session.currentUser = foundUser
            print("Usuario guardado: \(foundUser.name)")
            isLoggedIn = true

        } else {
            alertMessage = "Usuario o contraseña incorrectos."
            showAlert = true
        }
    }

}

#Preview {
    LoginView()
}
