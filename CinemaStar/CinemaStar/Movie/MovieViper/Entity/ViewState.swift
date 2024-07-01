// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///// Стейты загрузки

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

enum StateView<Generic: Equatable>: Equatable {
    case initial
    case loading
    case success(Generic)
    case failure

    static func == (lhs: StateView, rhs: StateView) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial),
             (.loading, .loading),
             (.failure, .failure):
            return true
        case let (.success(lhsValue), .success(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}
