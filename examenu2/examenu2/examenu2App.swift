//
//  examenu2App.swift
//  examenu2
//
//  Created by user286436 on 11/19/25.
//

import SwiftUI
import FirebaseCore


@main
struct examenu2App: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
