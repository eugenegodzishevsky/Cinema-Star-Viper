// ListInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

protocol ListInteractorProtocol {
    var presenter: ListPresenterProtocol? { get set }
    func fetchFilm()
    var networkService: NetworkRequest? { get set }
}

final class ListInteractor: ListInteractorProtocol {
    var networkService: NetworkRequest?

    // MARK: - Public Properties

    var presenter: ListPresenterProtocol?
    private var response = FilmsResourse()
    var cancellable: AnyCancellable?

    // MARK: - Initializers

    init(presenter: ListPresenterProtocol, networkService: NetworkRequest) {
        self.presenter = presenter
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func fetchFilm() {
        presenter?.state = .loading

        if let cachedData = CoreDataStorageService.shared.fetchMovieCards() {
            let films = cachedData.docs.map { ListOfFilmsModel(dto: $0) }
            presenter?.films = films
            presenter?.state = .success(films)
            return
        }

        guard let url = response.url else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ListDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                if case .failure = completion {
                    presenter?.state = .failure
                    return
                }
            } receiveValue: { [unowned self] result in
                let res = result.docs.map { ListOfFilmsModel(dto: $0.self) }
                presenter?.films = res
                if let films = presenter?.films, !films.isEmpty {
                    presenter?.state = .success(films)

                    CoreDataStorageService.shared.createMovieCards(result)
                }
            }
    }
}
