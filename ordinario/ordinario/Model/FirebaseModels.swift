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
}

struct ColorModes: Codable {
    let dark: ColorSet
    let light: ColorSet
}

struct ColorSet: Codable {
    let mainBg: String
}

struct AppStrings: Codable {
    let greetings: String
}

struct ResponseConfig {
    let background: String
    let greeting: String
}

