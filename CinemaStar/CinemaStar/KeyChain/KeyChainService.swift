// KeyChainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

/// Сервис для хранения API-ключа
final class KeyChainService {
    // MARK: - Constants

    enum Constants {
        static let key = "API key"
        static let keyNotFound = "key is not found in keyChain"
    }

    // MARK: - Private Properties

    private let keyChain = KeychainSwift()

    // MARK: - Initializers

    init() {
//        keyChain.set("92JSXDT-SVE4DKZ-KWA35X9-K3H52VA", forKey: Constants.key)
    }

    // MARK: - Public Methods

    func getAPIKey() -> String {
        keyChain.get(Constants.key) ?? Constants.keyNotFound
    }
}
