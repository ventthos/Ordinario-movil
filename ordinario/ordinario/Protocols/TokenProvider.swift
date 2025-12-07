//
//  TokenProvider.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

protocol TokenProvider {
    func fetchDesignTokens(completion: @escaping (ResponseConfig) -> Void)
}
