// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol Builder {
    /// Функция создания модуля главного экрана
    func createMainModule(coordinator: MovieCoordinatorProtocol) -> UIViewController
    /// Функция создания модуля экрана деталей
    func createDetailsModule(coordinator: MovieCoordinatorProtocol, id: Int) -> UIViewController
}

/// Билдер модулей
final class ModuleBuilder: Builder {
    // MARK: - Public Methods

    func createMainModule(coordinator: MovieCoordinatorProtocol) -> UIViewController {
        let view = MovieViewController()
        let imageNetworkService = ImageNetworkService()
        let moviesNetworkService = APIRequest(resource: MovieResource())
        let imageCacheProxyService = ImageCacheProxyService(
            networkService: imageNetworkService,
            fileManager: FileManager.default
        )
        let cacheService = CacheProxyService(
            resource: MovieResource(),
            networkService: moviesNetworkService,
            coreDataService: CoreDataStorageService.shared
        )
        view.viewModel = MovieViewModel(
            coordinator: coordinator,
            moviesNetworkService: cacheService,
            imageNetworkService: imageCacheProxyService
        )
        return view
    }

    func createDetailsModule(coordinator: MovieCoordinatorProtocol, id: Int) -> UIViewController {
        let view = DetailsViewController()
        let imageNetworkService = ImageNetworkService()
        let moviesNetworkService = APIRequest(resource: MovieDetailsResource(id: id))
        let imageCacheProxyService = ImageCacheProxyService(
            networkService: imageNetworkService,
            fileManager: FileManager.default
        )
        let cacheService = CacheProxyService(
            resource: MovieDetailsResource(id: id),
            networkService: moviesNetworkService,
            coreDataService: CoreDataStorageService.shared
        )
        view.viewModel = DetailsViewModel(
            coordinator: coordinator, id: id, moviesNetworkService: cacheService,
            imageNetworkService: imageCacheProxyService
        )
        return view
    }
}
