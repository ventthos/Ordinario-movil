//
//  ContentView.swift
//  ordinario
//
//  Created by user286436 on 12/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GradesView()
            .environmentObject( DesignTokensViewModel(tokenProvider: FirebaseTokenProvider()))
    }
}

#Preview {
    ContentView()
}
