//
//  LoginView.swift
//  ordinario
//
//  Created by user286436 on 12/2/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    private let imageURL = URL(string: "https://assetsio.gnwcdn.com/cover_7ovpf5l.jpg?width=1200&height=630&fit=crop&enable=upscale&auto=webp")!
    
    @State private var reloadToken = UUID()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // ---------------------------
            //   Imagen grande superior
            // ---------------------------
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color(.systemGray5)
                        ProgressView()
                    }
                case .success(let img):
                    img.resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                case .failure:
                    ZStack {
                        Color(.systemGray5)
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                    }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 300)
            .clipped()
            .id(reloadToken)
            
            
            // ----------------------------------------
            //   Tarjeta blanca sobre la imagen
            // ----------------------------------------
            VStack {
                
                Spacer().frame(height: 240) // mueve la tarjeta hacia abajo
                
                VStack(spacing: 25) {
                    
                    // Título
                    Text("Control Escolar")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black.opacity(0.85))
                        .padding(.top, 10)
                    
                    VStack(spacing: 18) {
                        TextField("Correo institucional", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .autocapitalization(.none)
                        
                        SecureField("Contraseña", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 15)
                    
                    Button {
                        withAnimation { isLoading = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            isLoading = false
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if isLoading {
                                ProgressView().tint(.white)
                            } else {
                                Text("Iniciar Sesión")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(14)
                    }
                    .disabled(isLoading)
                    .padding(.horizontal, 15)
                    .shadow(color: Color.black.opacity(0.12), radius: 8, y: 3)
                    
                    Button("¿Olvidaste tu contraseña?") {}
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .shadow(radius: 5)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    LoginView()
}


// Extensión para redondear solo algunas esquinas
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    LoginView()
}
