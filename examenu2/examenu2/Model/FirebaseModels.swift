//
//  FirebaseModels.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation


struct DesignToken: Codable {
    let name: String
    let values: [Value]
}


struct Value: Codable {
    let color: [Colors]?
    let mode: Mode
    let number, string: [Colors]?
}

struct Colors: Codable {
    let value, colorVar, name, rootAlias: String

    enum CodingKeys: String, CodingKey {
        case value
        case colorVar = "var"
        case name, rootAlias
    }
}


struct Mode: Codable {
    let id, name: String
}

typealias DesignTokens = [DesignToken]

enum APIDataSource {
    case firebase(DesignToken)
    
}

struct ResponseConfig: Codable {
    let name: String
    let bg_body: String
    let bg_bottom: String
    let button : String
    let contrasena: String
    let ingresar: String
    let fuente: String
    let border: CGFloat
    let border_small: CGFloat
    let tema: String
    let chartsAccentColor:String
    let journal:String
    let caloriescolor:String
    let tiempocolor:String
    let servingscolor:String
    let proteinscolor:String
    let carbscolor:String
    let fatscolor:String
    let chartsbackgroundcolor: String
    let chartsfontcolor: String
    let calendarText:String
    let borderTarjetas:CGFloat
    let progresoCalorias:CGFloat
    let avatarUrl: String
}


