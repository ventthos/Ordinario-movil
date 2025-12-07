import SwiftUI

struct SubjectListView: View {
    // Manejo de estado: La lista de materias
    @EnvironmentObject var viewModel: DesignTokensViewModel
    @State private var subjects: [Subject] = Subject.sampleSubjects
    
    // Color de fondo principal
    var primaryBackground: Color {
        if let hex = viewModel.config?.colors.background {
            return Color(hex: hex)
        }
        return Color(red: 28/255, green: 28/255, blue: 30/255)
    }
    
    var mainTextColor: Color {
        let hex = viewModel.config?.colors.mainFontColor ?? "#ffffff"
        return Color(hex: hex)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo oscuro principal
                primaryBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 12) {
                        // Título grande estilizado (similar al "Dashboard")
                        Text("Mis Cursos")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                            .padding(.leading)
                            .foregroundColor(mainTextColor)
                        
                        // Lista de tarjetas de cursos
                        ForEach(viewModel.config?.userData[0].subjects ?? []) { subject in
                            NavigationLink(destination: MateriaDetalleView(materia: subject)) {
                                SubjectCardView(subject: subject)
                                    .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20) // Espacio al final
                }
            }
            // Eliminar la Navigation Bar estándar para usar el título grande manual
            .navigationBarHidden(true)
        }
        // Asegurar que el esquema de color sea oscuro
        .preferredColorScheme(.dark)
    }
}


#Preview{
    SubjectListView()
        .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
}
