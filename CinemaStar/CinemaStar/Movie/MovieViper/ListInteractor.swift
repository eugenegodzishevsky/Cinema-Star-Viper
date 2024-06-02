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

    func fetchFilm() {
        print("Fetching film...")
        presenter?.state = .loading

        if let cachedData = CoreDataStorageService.shared.fetchMovieCards() {
            print("Cached data found.")
            let films = cachedData.docs.map { ListOfFilmsModel(dto: $0) }
            presenter?.films = films
            presenter?.state = .success(films)
            print("Film fetched successfully from cache.")
            return
        }

        guard let url = response.url else {
            print("URL is unavailable. Setting state to failure.")
            CoreDataStorageService.shared.deleteAllMovies()

            presenter?.state = .failure
            return
        }

        print("Fetching film from network...")
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ListDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    print("Failed to fetch film from network: \(error)")
                    self.presenter?.state = .failure
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                print("Film fetched successfully from network.")
                let res = result.docs.map { ListOfFilmsModel(dto: $0.self) }
                self.presenter?.films = res
                if !res.isEmpty {
                    print("Saving film to CoreData.")
                    self.presenter?.state = .success(res)
                    CoreDataStorageService.shared.createMovieCards(result)
                }
            })
    }
}
