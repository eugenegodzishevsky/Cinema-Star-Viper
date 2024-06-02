// ListOfFilmsModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель для данных фильма
final class ListOfFilmsModel: Decodable, Encodable, Equatable {
    // MARK: - Private Properties

    /// постер фильма
    let poster: String
    /// имя фильма
    let name: String
    /// оценка фильма
    let rating: Double
    /// id фильма
    let id: Int

    // MARK: - Initializers

    init(dto: DocDTO) {
        poster = dto.poster.url
        name = dto.name
        rating = dto.rating.kp
        id = dto.id
    }

    init(listModel: ListModel) {
        poster = listModel.poster
        name = listModel.nameOfFilm
        rating = listModel.rankOfFilm
        id = listModel.id
    }

    // MARK: - Equatable

    static func == (lhs: ListOfFilmsModel, rhs: ListOfFilmsModel) -> Bool {
        lhs.poster == rhs.poster &&
            lhs.name == rhs.name &&
            lhs.rating == rhs.rating &&
            lhs.id == rhs.id
    }
}
