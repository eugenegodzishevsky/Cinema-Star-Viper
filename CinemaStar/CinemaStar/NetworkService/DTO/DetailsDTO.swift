// DetailsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура для получения данных
struct DetailsDTO: Codable {
    /// Картинка фильма
    let poster: DetailsPosterDTO
    /// Имя фильма
    let name: String
    /// Рейтинг фильма
    let rating: DetailsRatingDTO
    /// id фильма
    let id: Int
    /// описание фильма
    let description: String
    /// год выпуска фильма
    let year: Int
    /// страна производства фильма
    let countries: [CountryDTO]
    /// тип
    let type: String
    /// актёры
    let persons: [PersonDTO]
    /// язык
    let spokenLanguages: [SpokenLanguageDTO]?
    /// рекомендованные фильмы
    let similarMovies: [SimilarMovieDTO]?
}
