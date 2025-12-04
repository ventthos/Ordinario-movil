//
//  Extensions.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255,
            opacity: 1.0
        )
    }
}


extension String {
    func toSwiftUIFont(size: CGFloat = 16) -> Font {
        Font.custom(self, size: size)
    }
}

