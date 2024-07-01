// DocDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// данные о фильме
struct DocDTO: Codable {
    /// название фильма
    let name: String
    /// рейтинг фильма
    let rating: RatingDTO
    /// постер фильма
    let poster: PosterDTO
    /// ID фильма
    let id: Int
}
