// DetailsModel.swift
// Copyright © RoadMap. All rights reserved.

/// Модель для данных экрана деталей
struct DetailsOfFilmModel: Decodable, Encodable {
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
