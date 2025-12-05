//
//  UserAdapter.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation

class UserAdapter {
    static func convert<T>(data: T) -> ResponseConfig {
        switch data {
        case let tokens as [DesignToken]:
            let tokenDict = Dictionary(grouping: tokens, by: { $0.name })
            
            let banTheme = tokenDict["Text"]?.first?.values.first?.mode.name ?? ""
            let filtro = tokenDict["Traducción"]?.first
            let colorTokens = banTheme == "light" ? tokenDict["Color"]?.first?.values.first?.color : tokenDict["Color"]?.first?.values[1].color
            let numbersToken = tokenDict["Numbers"]?.first?.values.first { $0.mode.name == "Large" }
            let valoresToken = tokenDict["Valores"]?.first?.values.first { $0.mode.name == "Default" }
            
            let texto = filtro?.values.first?.string?.first { $0.name == "Saludo" }?.value ?? ""
            let bg_body = colorTokens?.first { $0.name == "bg_body" }?.value ?? ""
            let bg_bottom = colorTokens?.first { $0.name == "bg_bottom" }?.value ?? ""
            let button = colorTokens?.first { $0.name == "button" }?.value ?? ""
            let contrasena = filtro?.values.first?.string?.first { $0.name == "Contraseña" }?.value ?? ""
            let ingresar = filtro?.values.first?.string?.first { $0.name == "Ingresar" }?.value ?? ""
            let chartsAccentColor = colorTokens?.first { $0.name == "chartsAccentColor" }?.value ?? ""
            let koko = filtro?.values.first?.string?.first { $0.name == "JournalMainText" }?.value ?? ""
            let caloriasColor = colorTokens?.first { $0.name == "caloriescolor" }?.value ?? ""
            let tiempoColor = colorTokens?.first { $0.name == "tiempocolor" }?.value ?? ""
            let servingsColor = colorTokens?.first { $0.name == "servingscolor" }?.value ?? ""
            let proteinColor = colorTokens?.first { $0.name == "proteinscolor" }?.value ?? ""
            let carbsColor = colorTokens?.first { $0.name == "carbscolor" }?.value ?? ""
            let fatsColor = colorTokens?.first { $0.name == "fatscolor" }?.value ?? ""
            let chartsBackgroundColor = colorTokens?.first { $0.name == "chartsbackgroundcolor" }?.value ?? ""
            let chartsFontColor = colorTokens?.first { $0.name == "chartsfontcolor" }?.value ?? ""
            let calendarText = filtro?.values.first?.string?.first { $0.name == "calendarText" }?.value ?? ""
            let cardsValue = numbersToken?.number?.first { $0.name == "Cards" }?.value ?? ""
            let progresoString = valoresToken?.number?.first { $0.name == "Progreso" }?.value ?? "0"
            let avatarUrl = valoresToken?.number?.first { $0.name == "AvatarUrl" }?.value ?? ""
            
            return ResponseConfig(
                    name: texto,
                    bg_body: bg_body,
                    bg_bottom: bg_bottom,
                    button: button,
                    contrasena: contrasena,
                    ingresar: ingresar,
                    fuente: "", border: 40, border_small: 20, tema: "",
                    chartsAccentColor: chartsAccentColor,
                    journal: koko,
                    caloriescolor:caloriasColor,
                    tiempocolor:tiempoColor,
                    servingscolor:servingsColor,
                    proteinscolor:proteinColor,
                    carbscolor:carbsColor,
                    fatscolor: fatsColor,
                    chartsbackgroundcolor: chartsBackgroundColor,
                    chartsfontcolor: chartsFontColor,
                    calendarText: calendarText,
                    borderTarjetas: CGFloat(Double(cardsValue.replacingOccurrences(of: "px", with: "")) ?? 0),
                    progresoCalorias: CGFloat(Double(progresoString) ?? 0),
                    avatarUrl: avatarUrl
            )
    
            
        default:
            return ResponseConfig(name: "", bg_body: "", bg_bottom: "", button: "", contrasena: "", ingresar: "",fuente: "", border: 40, border_small: 20, tema: "", chartsAccentColor:"", journal: "", caloriescolor:"", tiempocolor:"", servingscolor: "", proteinscolor:"", carbscolor:"", fatscolor: "", chartsbackgroundcolor: "", chartsfontcolor: "", calendarText: "", borderTarjetas:20, progresoCalorias: 0, avatarUrl: "")
        }
    }
}
