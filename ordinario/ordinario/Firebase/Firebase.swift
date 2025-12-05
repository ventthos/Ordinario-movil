//
//  Firebase.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import SwiftUI
import Firebase


class FirebaseTokenProvider : TokenProvider{
    private let databaseRef = Database.database().reference()
    
    func fetchDesignTokens(completion: @escaping (ResponseConfig) -> Void) {
        databaseRef.observe(.value) { snapshot in
            guard let value = snapshot.value else {
                print("❌ No se encontró data en Firebase")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                
                let appConfig = try JSONDecoder().decode(AppConfig.self, from: jsonData)
                
                let config = UserAdapter.convert(config: appConfig)
                
                DispatchQueue.main.async {
                    completion(config)
                }
                
            } catch {
                print("❌ Error al decodificar JSON: \(error.localizedDescription)")
            }
        }
    }
}
