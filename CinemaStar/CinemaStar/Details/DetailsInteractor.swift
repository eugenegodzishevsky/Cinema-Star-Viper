// DetailsInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

protocol DetailsInteractorProtocol {
    var presenter: DetailsPresenterProtocol? { get set }
    func fetchDetails(id: Int)
}

final class DetailsInteractor: DetailsInteractorProtocol {
    // MARK: - Public Properties
    
    var presenter: DetailsPresenterProtocol?
    private var response = FilmsResourse()
    private var cancellable: AnyCancellable?
    
    // MARK: - Initializers
    
    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    
    func fetchDetails(id: Int) {
        response.id = id
        presenter?.state = .loading

        if let cachedData = CoreDataStorageService.shared.fetchMovieDetails(Int32(id)) {
            let details = DetailsOfFilmModel(dto: cachedData)
            presenter?.details = details
            presenter?.state = .success(details)
            return
        }

        guard let url = response.urlDetails else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DetailsDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                if case .failure = completion {
                    presenter?.state = .failure
                    return
                }
            } receiveValue: { [unowned self] details in
                let det = DetailsOfFilmModel(dto: details)
                presenter?.details = det
                presenter?.state = .success(det)
                CoreDataStorageService.shared.createMovieDetails(details, id: Int32(id))
            }
    }

}
