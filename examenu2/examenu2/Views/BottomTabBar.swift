//
//  BottomTabBar.swift
//  examenu2
//
//  Created by user286436 on 11/19/25.
//

import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            tabButton(index: 0, image: "dashboard")
            Spacer()
            tabButton(index: 1, image: "box")
            Spacer()
            
            // Botón central (se mantiene igual)
            Button { selectedTab = 2 } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color(hex: "#f470b3"))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
            }
            .offset(y: -20)
            
            Spacer()
            tabButton(index: 3, image: "book")
            Spacer()
            tabButton(index: 4, image: "profile")
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(Color.white)
    }
    
    // MARK: - Reusable Button
    func tabButton(index: Int, image: String) -> some View {
        Button { selectedTab = index } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(10)
                .background(
                    Circle()
                        .fill(Color(hex:"#b6aefd").opacity(0.8))
                        .opacity(selectedTab == index ? 1 : 0)
                )
                .animation(.easeInOut(duration: 0.15), value: selectedTab)
        }
    }
}
