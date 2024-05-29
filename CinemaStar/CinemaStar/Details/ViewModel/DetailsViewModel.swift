// DetailsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью модели экрана деталей
protocol DetailsViewModelProtocol {
    /// Состояние данных
    var state: ViewState<MovieDetails> { get set }
    /// Состояние добавления в избранное
    var isFavorite: Bool { get set }
    /// Замыкание для обновления таблицы
    var updateTableView: VoidHandler? { get set }
    /// Функция получения данных
    func moviesRequest()
    /// Запрос изображения фильма
    func fetchMovieImage(url: URL, completion: @escaping DataHandler)
    /// Возврат на главный экран
    func openMainScreen()
    /// установка картинки для избранного
    func returnHeartImage() -> UIImage
    /// сэйв таппед
    func heartTapped()
    /// Проверка на лайк
    func checkLikeButtonState() -> UIImage
}

/// Вью модель главного экрана
final class DetailsViewModel<MoviesNetwork: NetworkRequest, ImageNetwork: NetworkRequest>: DetailsViewModelProtocol {
    // MARK: - Public Properties

    var state: ViewState<MovieDetails> {
        didSet {
            updateTableView?()
        }
    }

    var isFavorite = false {
        didSet {
            UserDefaults.standard.setValue(isFavorite, forKey: "\(id)")
        }
    }

    var updateTableView: VoidHandler?

    // MARK: - Private Properties

    private let id: Int
    private var coordinator: MovieCoordinatorProtocol?
    private var moviesNetworkService: MoviesNetwork?
    private var imageNetworkService: ImageNetwork?

    // MARK: - Initializers

    init(
        coordinator: MovieCoordinatorProtocol,
        id: Int,
        moviesNetworkService: MoviesNetwork,
        imageNetworkService: ImageNetwork
    ) {
        self.coordinator = coordinator
        self.imageNetworkService = imageNetworkService
        self.moviesNetworkService = moviesNetworkService
        self.id = id
        state = .loading
    }

    // MARK: - Public Methods

    func moviesRequest() {
        moviesNetworkService?.execute { [weak self] film in
            switch film {
            case let .success(film):
                guard let film = film as? DocsDTO else { return }
                self?.state = .data(MovieDetails(dto: film))
            case let .failure(error):
                self?.state = .error(error) {}
            }
        }
    }

    func fetchMovieImage(url: URL, completion: @escaping DataHandler) {
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

    func openMainScreen() {
        coordinator?.returnToMainScreen()
    }

    func returnHeartImage() -> UIImage {
        guard let heartImage = UIImage(systemName: "heart"),
              let filledHeartImage = UIImage(systemName: "heart.fill") else { return UIImage() }
        return isFavorite ? filledHeartImage : heartImage
    }

    func heartTapped() {
        isFavorite.toggle()
    }

    func checkLikeButtonState() -> UIImage {
        isFavorite = UserDefaults.standard.bool(forKey: "\(id)")
        print(isFavorite)
        return returnHeartImage()
    }
}
