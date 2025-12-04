//
//  DailySummaryView.swift
//  examenu2
//
//  Created by user286436 on 11/19/25.
//

import SwiftUI

struct DailySummaryView: View {
    @EnvironmentObject var viewModel: DesignTokensViewModel
    
    var body: some View {
        // 1. IMPORTANTE: Todo debe estar dentro de NavigationView para poder navegar a los detalles
        NavigationView {
            Group {
                if let config = viewModel.config {
                    VStack(spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                HeaderView(avatarURL: viewModel.config?.avatarUrl ?? "")
                                    .environmentObject(viewModel)
                                
                                DailyGoalChartView()
                                    .environmentObject(viewModel)
                                
                                // Aquí adentro están los NavigationLink, por eso necesitamos el NavigationView arriba
                                MyJournalContainer()
                                    .environmentObject(viewModel)
                            }
                            .padding(.top)
                        }
                        .background(Color(hex: config.bg_bottom).edgesIgnoringSafeArea(.all))
                    }
                } else {
                    // 2. IMPORTANTE: Si config es nulo (está cargando), mostramos esto en lugar de nada
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Cargando recursos...")
                            .foregroundColor(.gray)
                            .padding(.top)
                    }
                }
            }
            // Ocultamos la barra de navegación superior en esta vista principal para que se vea limpio
            // (La vista de detalle SÍ tendrá su propia barra customizada)
            .navigationBarHidden(true)
        }
        // Esto asegura que la navegación funcione bien en estilos de iPad/iPhone grandes
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DailySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DailySummaryView()
    }
}
