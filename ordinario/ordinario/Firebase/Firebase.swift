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
                
                let decoder = JSONDecoder()

                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                decoder.dateDecodingStrategy = .formatted(formatter)

                let appConfig = try decoder.decode(AppConfig.self, from: jsonData)
                
                let config = UserAdapter.convert(config: appConfig)
                
                DispatchQueue.main.async {
                    completion(config)
                }

            } catch {
                print("❌ Error al decodificar JSON: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUserData(userIndex: Int, completion: @escaping (UserData) -> Void) {
        databaseRef
            .child("users")
            .child("\(userIndex)")
            .observeSingleEvent(of: .value) { snapshot, _ in
                
                do {
                    let json = try JSONSerialization.data(withJSONObject: snapshot.value ?? [:])
                    let decoder = JSONDecoder()
                    let userDb = try decoder.decode(UserDataDb.self, from: json)
                    
                    let userParsed = UserAdapter.convertUserData(user: userDb)
                    completion(userParsed)  
                } catch {
                    print("❌ Error al decodificar: \(error)")
                }
            }
    }

}
