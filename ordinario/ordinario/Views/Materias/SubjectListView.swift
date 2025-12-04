import SwiftUI

struct SubjectListView: View {
    // Manejo de estado: La lista de materias
    @State private var subjects: [Subject] = Subject.sampleSubjects
    
    // Color de fondo principal oscuro (#1C1C1E)
    let primaryBackground = Color(red: 28/255, green: 28/255, blue: 30/255)
    
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
                            .foregroundColor(.white)
                        
                        // Lista de tarjetas de cursos
                        ForEach(subjects) { subject in
                            NavigationLink(destination: MateriaDetalleView(materia: subject)) {
                                SubjectCardView(subject: subject)
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
}
