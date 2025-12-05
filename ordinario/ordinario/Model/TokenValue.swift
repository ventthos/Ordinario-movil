//
//  TokenValue.swift
//  ordinario
//
//  Created by user286436 on 12/5/25.
//

enum TokenValue: Codable {
    case color(String)
    case number(Double)
    case string(String)
    case object([String: TokenValue])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let num = try? container.decode(Double.self) {
            self = .number(num)
            return
        }
        
        if let str = try? container.decode(String.self) {
            self = .string(str)
            return
        }
        
        if let dict = try? container.decode([String: TokenValue].self) {
            self = .object(dict)
            return
        }
        
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Valor de token desconocido"
        )
    }
}

extension TokenValue {
    var colorValue: String? {
        if case let .string(v) = self { return v }
        return nil
    }

    var numberValue: Double? {
        if case let .number(v) = self { return v }
        return nil
    }
    
    var stringValue: String? {
        if case let .string(v) = self { return v }
        return nil
    }
}
