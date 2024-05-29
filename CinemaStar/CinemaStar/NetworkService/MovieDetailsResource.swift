// MovieDetailsResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура сборки ссылки деталей фильма
struct MovieDetailsResource: APIResource {
    // MARK: - Types

    typealias ModelType = DocsDTO

    // MARK: - Public Properties

    var id: Int?

    var methodPath: String {
        guard let id = id else {
            return ""
        }
        return "/\(id)"
    }
}
