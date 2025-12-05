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
        let bgColor = isDark ? config.colors.dark.mainBg : config.colors.light.mainBg
        
        return ResponseConfig(
            background: bgColor,
            greeting: config.strings.greetings
        )
    }
}
