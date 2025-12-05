//
//  UserAdapter.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation

class UserAdapter {
    static func convert(config: AppConfig) -> ResponseConfig {
        
        // elegir modo
        let isDark = config.mode == "dark"
        let modeColors = isDark ? config.colors.dark : config.colors.light
        
        // strings
        let strings = config.strings
        
        // Valores
        let appValues = config.values
        
        return ResponseConfig(
            colors: .init(
                background: modeColors.mainBg,
                cardBackground: modeColors.cardBackground,
                mainColor: modeColors.mainColor,
                mainFontColor: modeColors.mainFontColor
            ),
            strings: .init(
                greeting: strings.greetings,
                nombreInstitucion: strings.nombreInstitucion
            ),
            values: .init(
                logoUrl: appValues.logoUrl
            )
        )
    }
}
