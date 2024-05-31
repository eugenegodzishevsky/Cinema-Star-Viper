// SimilarMovieDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рекомендованные фильмы
struct SimilarMovieDTO: Codable {
    /// Название рек. фильма
    let name: String
    /// Картинка рек. фильма
    let poster: PosterDTO
}
