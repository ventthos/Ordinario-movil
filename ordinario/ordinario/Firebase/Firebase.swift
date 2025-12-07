//
//  Firebase.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import SwiftUI
import Firebase


class FirebaseTokenProvider : TokenProvider {
    private let databaseRef = Database.database().reference()
    private var institutionObserverHandle: DatabaseHandle?
    
    func fetchDesignTokens(completion: @escaping (ResponseConfig) -> Void) {
        
        databaseRef.observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            
            guard let root = snapshot.value as? [String: Any],
                  let currentInstitution = root["currentInstitution"] as? String,
                  !currentInstitution.isEmpty else {
                print("No se encontró currentInstitution")
                return
            }
            
            print("Institución activa ahora:", currentInstitution)
            
            if let handle = self.institutionObserverHandle {
                self.databaseRef.removeObserver(withHandle: handle)
            }
            
            let institutionRef = self.databaseRef
                .child("institutions")
                .child(currentInstitution)
            
            self.institutionObserverHandle = institutionRef.observe(.value) { institutionSnapshot in
                guard let institutionData = institutionSnapshot.value else {
                    print("❌ No hay datos de la institución \(currentInstitution)")
                    return
                }
                
                do {
                    // Convertimos a JSON
                    let jsonData = try JSONSerialization.data(withJSONObject: institutionData)
                    
                    // Decoder de fecha
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    
                    // Decodificamos AppConfig
                    let appConfig = try decoder.decode(AppConfig.self, from: jsonData)
                    
                    // Adaptamos al formato usado por la app
                    let config = UserAdapter.convert(config: appConfig)
                    
                    DispatchQueue.main.async {
                        completion(config)
                    }
                } catch {
                    print("❌ Error decodificando institución: \(error.localizedDescription)")
                }
            }
        }
    }
}
