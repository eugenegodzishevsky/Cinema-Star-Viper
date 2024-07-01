// DetailsModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Протокол Equatable для PersonDTO
extension PersonDTO: Equatable {
    static func == (lhs: PersonDTO, rhs: PersonDTO) -> Bool {
        lhs.photo == rhs.photo && lhs.name == rhs.name
    }
}

// Протокол Equatable для SimilarMovieDTO
extension SimilarMovieDTO: Equatable {
    static func == (lhs: SimilarMovieDTO, rhs: SimilarMovieDTO) -> Bool {
        lhs.name == rhs.name && lhs.poster == rhs.poster
    }
}

// Протокол Equatable для PosterDTO
extension PosterDTO: Equatable {
    static func == (lhs: PosterDTO, rhs: PosterDTO) -> Bool {
        lhs.url == rhs.url
    }
}

/// Модель для данных экрана деталей
struct DetailsOfFilmModel: Decodable, Encodable, Equatable {
    /// постер фильма
    let poster: String
    /// имя фильма
    let nameOfFilm: String
    /// оценка фильма
    let rankOfFilm: Double
    /// id фильма
    let id: Int
    /// описание фильма
    let description: String
    /// год выпуска фильма
    let year: Int
    /// страна
    let countres: String
    /// тип
    let type: String
    /// актеры
    let persons: [PersonDTO]
    /// язык
    let spokenLanguages: String
    /// рекомендованные фильмы
    let simularMovies: [SimilarMovieDTO]

    init(dto: DetailsDTO) {
        poster = dto.poster.url
        nameOfFilm = dto.name
        rankOfFilm = dto.rating.kp
        id = dto.id
        description = dto.description
        year = dto.year
        countres = dto.countries.first?.name ?? ""
        type = dto.type
        persons = dto.persons
        spokenLanguages = dto.spokenLanguages?.first?.name ?? ""
        simularMovies = dto.similarMovies ?? []
    }

    static func == (lhs: DetailsOfFilmModel, rhs: DetailsOfFilmModel) -> Bool {
        lhs.poster == rhs.poster &&
            lhs.nameOfFilm == rhs.nameOfFilm &&
            lhs.rankOfFilm == rhs.rankOfFilm &&
            lhs.id == rhs.id &&
            lhs.description == rhs.description &&
            lhs.year == rhs.year &&
            lhs.countres == rhs.countres &&
            lhs.type == rhs.type &&
            lhs.persons == rhs.persons &&
            lhs.spokenLanguages == rhs.spokenLanguages &&
            lhs.simularMovies == rhs.simularMovies
    }
}

extension DetailsOfFilmModel {
    func toDocDTO() -> DocDTO {
        DocDTO(
            name: nameOfFilm,
            rating: RatingDTO(kp: rankOfFilm),
            poster: PosterDTO(url: poster),
            id: id
        )
    }
}

extension DetailsOfFilmModel {
    func toDetailsDTO() -> DetailsDTO {
        DetailsDTO(
            poster: DetailsPosterDTO(url: poster),
            name: nameOfFilm,
            rating: DetailsRatingDTO(kp: rankOfFilm),
            id: id,
            description: description,
            year: year,
            countries: [CountryDTO(name: countres)],
            type: type,
            persons: persons,
            spokenLanguages: [SpokenLanguageDTO(name: spokenLanguages)],
            similarMovies: simularMovies
        )
    }
}
