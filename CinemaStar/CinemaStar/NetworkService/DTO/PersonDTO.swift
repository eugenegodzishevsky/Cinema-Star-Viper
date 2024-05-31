// PersonDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Актёры
struct PersonDTO: Codable {
    /// фото актера
    let photo: String
    /// имя актера
    let name: String?
}
