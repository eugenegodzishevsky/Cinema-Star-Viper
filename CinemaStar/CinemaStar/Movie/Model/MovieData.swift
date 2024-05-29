// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные фильма
struct MovieData {
    /// Имя фильма
    let movieName: String
    /// Рейтинг фильма
    let movieRating: String?
    /// Ссылка на изображение
    let imageURL: URL?
    /// ID фильма
    let id: Int

    init(dto: DocsDTO) {
        movieName = dto.name
        movieRating = String(format: "%.1f", dto.rating?.kp ?? 0)
        imageURL = URL(string: dto.poster.url)
        id = dto.id
    }
}
