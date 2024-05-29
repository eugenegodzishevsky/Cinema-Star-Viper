// FilmsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ДТО модель фильмов
struct FilmsDTO: Codable {
    /// ДТО модель docs с массивом информации о фильмах
    let docs: [DocsDTO]
}
