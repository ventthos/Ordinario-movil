//
//  DesignTokensViewModel.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI
internal import Combine


class DesignTokensViewModel: ObservableObject {
    //@Published var tokens: DesignTokens? = nil
    @Published var config: ResponseConfig? = nil
    private var tokenProvider: TokenProvider
    
    init(tokenProvider: TokenProvider) {
        self.tokenProvider = tokenProvider
        fetchTokens()
    }
    
    func fetchTokens() {
        tokenProvider.fetchDesignTokens { [weak self] tokens in
            self?.config = tokens
        }
    }
}
