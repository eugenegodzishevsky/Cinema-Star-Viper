// CacheProxyService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Network

/// Прокси сервис кеширования данных
final class CacheProxyService<Resource: APIResource> {
    // MARK: - Constants

    private let queueLabel = "Monitor"

    // MARK: - Public Properties

    private let resource: Resource
    private let networkService: any NetworkRequest
    private let coreDataService: CoreDataStorageServiceProtocol

    // MARK: - Initializers

    init(resource: Resource, networkService: any NetworkRequest, coreDataService: CoreDataStorageServiceProtocol) {
        self.resource = resource
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
}

// MARK: - CascheProxyService + NetworkRequest

extension CacheProxyService: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Resource.ModelType.self, from: data)
    }

    func execute(withCompletion completion: @escaping (Result<Resource.ModelType?, any Error>) -> Void) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                func proxyCompletion(_ resource: Result<Resource.ModelType?, any Error>) {
                    switch resource {
                    case let .success(data):
                        if let films = data as? FilmsDTO {
                            self.coreDataService.updateMovieCards(newMovieCards: films)
                            completion(resource)
                        } else if let detail = data as? DocsDTO {
                            self.coreDataService.updateMovieDetailsCards(Int32(detail.id), newMovieCard: detail)
                            completion(resource)
                        }
                    default:
                        completion(.failure(NetworkError.networkError(0)))
                    }
                }
                load(self.resource.url, withCompletion: proxyCompletion)
            } else {
                if self.resource is MovieResource {
                    completion(.success(self.coreDataService.fetchMovieCards() as? Resource.ModelType))
                } else if let detail = self.resource as? MovieDetailsResource, let id = detail.id {
                    completion(.success(self.coreDataService.fetchMovieDetails(Int32(id)) as? Resource.ModelType))
                }
            }
        }
        let queue = DispatchQueue(label: queueLabel)
        monitor.start(queue: queue)
    }
}
