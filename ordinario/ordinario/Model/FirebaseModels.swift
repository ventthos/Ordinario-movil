//
//  FirebaseModels.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation



struct AppConfig: Codable {
    let colors: ColorModes
    let mode: String
    let strings: AppStrings
    let values: AppValues
}

struct ColorModes: Codable {
    let dark: ColorSet
    let light: ColorSet
}

struct ColorSet: Codable {
    let mainBg: String
    let cardBackground: String
    let mainColor: String
    let mainFontColor: String
}

struct AppStrings: Codable {
    let greetings: String
    let nombreInstitucion: String
}

struct AppValues: Codable{
    let logoUrl: String
}

struct ResponseConfig {
    struct Colors {
        let background: String
        let cardBackground: String
        let mainColor: String
        let mainFontColor: String
    }
    struct Strings {
        let greeting: String
        let nombreInstitucion: String
    }

    struct ValuesForApp{
        let logoUrl: String
    }
    
    let colors: Colors
    let strings: Strings
    let values: ValuesForApp
}
