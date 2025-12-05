//
//  MainTabView.swift
//  ordinario
//
//  Created by user286436 on 12/4/25.
//


import SwiftUI

struct MainTabView: View {
    
    // 🔶 Color institucional
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)
    
    // Para saber en qué tab estamos
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            

            
        }
        // Tab bar oscura
        .tint(accentColor)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainTabView()
}
