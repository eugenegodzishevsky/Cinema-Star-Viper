// ListRouter.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

typealias StartPoint = UIViewController

protocol ListRouterProtocol {
    var entry: StartPoint? { get }
    func start() -> ListRouterProtocol
    func goToDetail(id: Int)
}

final class ListRouter: ListRouterProtocol {
    // MARK: - Public Properties

    var entry: StartPoint?

    func start() -> ListRouterProtocol {
        let networkService = NetworkService()
        let router = ListRouter()
        let presenter = ListPresenter()
        let interactor: ListInteractorProtocol = ListInteractor(
            presenter: presenter,
            networkService: networkService
        )

        presenter.listInteractor = interactor
        presenter.listRouter = router

        let listView = ListView(presenter: presenter)
        let hostingController = UIHostingController(rootView: listView)
        router.entry = hostingController
        return router
    }

    func goToDetail(id: Int) {
        let detailsView = DetailsRouter().start(id: id)
        entry?.navigationController?.pushViewController(detailsView.entry ?? UIViewController(), animated: true)
    }
}
