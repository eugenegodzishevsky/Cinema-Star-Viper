// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные  фильма
struct MovieDetails {
    /// Имя фильма
    let movieName: String
    /// Рейтинг фильма
    let movieRating: String?
    /// Ссылка на изображение
    let imageURL: URL?
    /// ID фильма
    let id: Int
    /// Описание фильма
    let description: String?
    /// Год выпуска
    let year: Int?
    /// Страны
    let country: String?
    /// Тип контента
    let contentType: String?
    /// Aктеры
    var actors: [MovieActor] = []
    /// Язык
    let language: String?
    /// Похожие фильмы
    var similarMovies: [MovieData] = []

    init(dto: DocsDTO) {
        movieName = dto.name
        movieRating = String(format: "%.1f", dto.rating?.kp ?? 0)
        imageURL = URL(string: dto.poster.url)
        id = dto.id
        description = dto.description
        year = dto.year
        country = dto.countries?.first?.name ?? ""
        contentType = dto.type == "movie" ? "Фильм" : "Сериал"

        language = dto.spokenLanguages?.first?.name
        dto.persons?.forEach { actor in
            if let actor = MovieActor(dto: actor) {
                actors.append(actor)
            }
        }
        dto.similarMovies?.forEach { similarMovies.append(MovieData(dto: $0)) }
    }
}
