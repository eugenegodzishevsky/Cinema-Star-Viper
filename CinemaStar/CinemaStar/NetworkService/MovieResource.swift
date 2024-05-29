// MovieResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол ссылки API-запроса
protocol APIResource {
    /// Тип данных для декодирования
    associatedtype ModelType: Decodable
    /// Путь запроса
    var methodPath: String { get }
}

// MARK: - Составление базы ссылки

extension APIResource {
    var url: URL? {
        var components = URLComponents(string: "https://api.kinopoisk.dev/v1.4/movie") ?? URLComponents()
        components.path += methodPath
        if methodPath == "/search" {
            components.queryItems = [URLQueryItem(name: "query", value: "История")]
        }
        return components.url
    }
}

/// Структура сборки ссылки
struct MovieResource: APIResource {
    // MARK: - Constants

    enum Constants {
        static let methodPathText = "/search"
    }

    // MARK: - Types

    typealias ModelType = FilmsDTO

    // MARK: - Public Properties

    var methodPath = Constants.methodPathText
}
