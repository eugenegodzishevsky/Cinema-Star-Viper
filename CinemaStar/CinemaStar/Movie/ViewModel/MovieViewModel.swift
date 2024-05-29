// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели главного экрана
protocol MovieViewModelProtocol {
    /// Состояние данных
    var state: ViewState<[MovieData]> { get set }
    /// Замыкание для обновления таблицы
    var updateCollectionView: VoidHandler? { get set }
    /// Функция получения данных
    func moviesRequest()
    /// Запрос изображения фильма
    func fetchMovieImage(url: URL, completion: @escaping DataHandler)
    /// Переход на экран деталей
    func openDetailsScreen(filmNumber: Int)
}

/// Вью модел главного экрана
final class MovieViewModel<MoviesNetwork: NetworkRequest, ImageNetwork: NetworkRequest>: MovieViewModelProtocol {
    // MARK: - Public Properties

    var state: ViewState<[MovieData]> {
        didSet {
            updateCollectionView?()
        }
    }

    var updateCollectionView: VoidHandler?

    // MARK: - Private Properties

    private var coordinator: MovieCoordinatorProtocol?
    private var moviesNetworkService: MoviesNetwork?
    private var imageNetworkService: ImageNetwork?

    // MARK: - Initializers

    init(
        coordinator: MovieCoordinatorProtocol,
        moviesNetworkService: MoviesNetwork,
        imageNetworkService: ImageNetwork
    ) {
        self.coordinator = coordinator
        self.moviesNetworkService = moviesNetworkService
        self.imageNetworkService = imageNetworkService
        state = .loading
    }

    // MARK: - Public Methods

    func moviesRequest() {
        moviesNetworkService?.execute { [weak self] films in
            switch films {
            case let .success(films):
                guard let films = films as? FilmsDTO, !films.docs.isEmpty else {
                    self?.state = .noData()
                    return
                }

                var movies: [MovieData] = []
                for movie in films.docs {
                    movies.append(MovieData(dto: movie))
                }

                self?.state = .data(movies)
            case let .failure(error):
                self?.state = .error(error) {}
            }
        }
    }

    func fetchMovieImage(url: URL, completion: @escaping (DataHandler)) {
        guard let imageNetworkService = imageNetworkService as? ImageCacheProxyService else { return }
        imageNetworkService.url = url
        imageNetworkService.execute { result in
            switch result {
            case let .success(imageData):
                guard let imageData = imageData else { return }
                completion(imageData)
            default:
                break
            }
        }
    }

    func openDetailsScreen(filmNumber: Int) {
        guard case let .data(movies) = state else { return }
        coordinator?.openMovieDetails(id: movies[filmNumber].id)
    }
}
