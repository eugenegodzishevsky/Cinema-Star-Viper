// KeyChainService.swift
// Copyright © RoadMap. All rights reserved.

import KeychainSwift

/// протокол для использования keyChain
protocol KeyChainProtocol: AnyObject {
    /// сохранение
    func saveToken(_ token: String, forKey key: String)
    /// загрузка
    func loadToken(forKey key: String) -> String?
    /// удаление
    func deleteToken(forKey key: String)
}

/// keyChain
final class KeyChain: KeyChainProtocol {
    private let keychain = KeychainSwift()

    func saveToken(_ token: String, forKey key: String) {
        keychain.set(token, forKey: key)
    }

    func loadToken(forKey key: String) -> String? {
        keychain.get(key)
    }

    func deleteToken(forKey key: String) {
        keychain.delete(key)
    }
}
