// ListPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

protocol ListPresenterProtocol {
    var listRouter: ListRouterProtocol? { get set }
    var listInteractor: ListInteractorProtocol? { get set }
    var films: [ListOfFilmsModel]? { get set }
    var state: StateView<[ListOfFilmsModel]> { get set }
    func getFilms()
    func goToDetail(id: Int)
    var isShowDetails: Bool { get set }
    var id: Int? { get set }
}

final class ListPresenter: ListPresenterProtocol, ObservableObject {
    @Published var id: Int?
    @Published var state: StateView<[ListOfFilmsModel]> = .initial
    @Published var films: [ListOfFilmsModel]?
    @Published var isShowDetails = false

    // MARK: - Public Properties

    var listRouter: ListRouterProtocol?
    var listInteractor: ListInteractorProtocol?

    // MARK: - Public Methods

    func getFilms() {
        listInteractor?.fetchFilm()
    }

    func goToDetail(id: Int) {
        listRouter?.goToDetail(id: id)
    }
}
