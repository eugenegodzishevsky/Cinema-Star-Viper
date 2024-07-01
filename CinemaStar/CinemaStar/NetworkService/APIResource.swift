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
        keyChain.saveToken(Strings.apiToken, forKey: Strings.token)
        let token = keyChain.loadToken(forKey: Strings.token)
        var components = URLComponents()
        components.scheme = Strings.https
        components.host = Strings.apiKinopoiskDev
        components.path = methodPath
        components.queryItems = [URLQueryItem(name: Strings.query, value: Strings.history)]
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: Strings.xapikey)

        return request
    }

    /// вычисляемое свойста для составление url запроса для деталей фильмов
    var urlDetails: URLRequest? {
        let keyChain = KeyChain()
        keyChain.saveToken(Strings.apiToken, forKey: Strings.token)
        let token = keyChain.loadToken(forKey: Strings.token)
        var components = URLComponents()
        components.scheme = Strings.https
        components.host = Strings.apiKinopoiskDev
        components.path = methodPathDetail
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: Strings.xapikey)

        return request
    }
}

/// Структура для path
struct FilmsResourse: APIResource {
    var id: Int?
//    var url: String?

    var methodPath: String {
        Strings.movieSearch
    }

    var methodPathDetail: String {
        "\(Strings.movie)\(id ?? 0)"
    }
}
