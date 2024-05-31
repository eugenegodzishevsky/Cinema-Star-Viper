// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Стейты загрузки
enum StateView<Generic> {
    /// дефолтный
    case initial
    /// загрузка
    case loading
    /// загружено
    case success(Generic)
    /// ошибка
    case failure
}

enum StateViewDetails<Generic> {
    /// дефолтный
    case initial
    /// загрузка
    case loading
    /// загружено
    case success([Generic])
    /// ошибка
    case failure
}
