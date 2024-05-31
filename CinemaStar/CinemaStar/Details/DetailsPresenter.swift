// DetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailsPresenterProtocol {
    var detailsRouter: DetailsRouterProtocol? { get set }
    var detailsInteractor: DetailsInteractorProtocol? { get set }
    var details: DetailsOfFilmModel? { get set }
    var state: StateView<DetailsOfFilmModel> { get set }
    func getDetails(id: Int)
    func convertTypeOfFilm() -> String
    var isShowAlert: Bool { get set }
    var isFavourite: Bool { get set }
    var isfullInformationAboutFilm: Bool { get set }
    var id: Int? { get set }
}

final class DetailsPresenter: DetailsPresenterProtocol, ObservableObject {
    @Published var id: Int?
    @Published var isFavourite = false
    @Published var isfullInformationAboutFilm = false
    @Published var isShowAlert = false
    @Published var state: StateView<DetailsOfFilmModel> = .initial
    @Published var details: DetailsOfFilmModel?

    // MARK: - Public Properties

    var detailsRouter: DetailsRouterProtocol?
    var detailsInteractor: DetailsInteractorProtocol?

    // MARK: - Public Methods

    func getDetails(id: Int) {
        detailsInteractor?.fetchDetails(id: id)
    }

    func convertTypeOfFilm() -> String {
        if details?.type == "tv-series" {
            return "Сериал"
        } else {
            return "Фильм"
        }
    }
}
