// APIResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// протокол APIResource
protocol APIResource {
    /// path для фильмов
    var methodPath: String { get }
    /// path для деталей
    var methodPathDetail: String { get }
}

/// Расширение для APIResource
extension APIResource {
    /// вычисляемое свойста для составление url запроса для фильмов
    var url: URLRequest? {
        let keyChain = KeyChain()
        keyChain.saveToken("92JSXDT-SVE4DKZ-KWA35X9-K3H52VA", forKey: "token")
        let token = keyChain.loadToken(forKey: "token")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.kinopoisk.dev"
        components.path = methodPath
        components.queryItems = [URLQueryItem(name: "query", value: "история")]
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "X-API-KEY")

        return request
    }

    /// вычисляемое свойста для составление url запроса для деталей фильмов
    var urlDetails: URLRequest? {
        let keyChain = KeyChain()
        keyChain.saveToken("92JSXDT-SVE4DKZ-KWA35X9-K3H52VA", forKey: "token")
        let token = keyChain.loadToken(forKey: "token")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.kinopoisk.dev"
        components.path = methodPathDetail
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "X-API-KEY")

        return request
    }
}

/// Структура для path
struct FilmsResourse: APIResource {
    var id: Int?
//    var url: String?

    var methodPath: String {
        "/v1.4/movie/search"
    }

    var methodPathDetail: String {
        "/v1.4/movie/\(id ?? 0)"
    }
}
