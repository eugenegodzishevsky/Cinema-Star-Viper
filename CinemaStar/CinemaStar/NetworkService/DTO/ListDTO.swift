// ListDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фильм
struct ListDTO: Codable {
    /// массив с данными о фильме
    let docs: [DocDTO]
}

extension ListDTO {
    init(models: [ListOfFilmsModel]) {
        docs = models.map { model in
            let docDTO = DocDTO(
                name: model.name,
                rating: RatingDTO(kp: model.rating),
                poster: PosterDTO(url: model.poster),
                id: model.id
            )
            return docDTO
        }
    }
}
