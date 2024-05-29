// ImageRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Нетворк сервис запроса изображения
final class ImageNetworkService {
    // MARK: - Public Properties

    var url: URL?
}

// MARK: - ImageRequest + NetworkRequest

extension ImageNetworkService: NetworkRequest {
    func decode(_ data: Data) -> Data? {
        data
    }

    func execute(withCompletion completion: @escaping (Result<Data?, any Error>) -> Void) {
        load(url, withCompletion: completion)
    }
}
