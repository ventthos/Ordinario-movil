//
//  ordinarioApp.swift
//  ordinario
//
//  Created by user286436 on 12/2/25.
//

import SwiftUI
import FirebaseCore

@main
struct ordinarioApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
