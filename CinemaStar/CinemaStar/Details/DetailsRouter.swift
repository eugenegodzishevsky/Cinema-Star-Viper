// DetailsRouter.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

protocol DetailsRouterProtocol {
    var entry: StartPoint? { get }
    func start(id: Int) -> DetailsRouterProtocol
    func goBack()
}

final class DetailsRouter: DetailsRouterProtocol {
    // MARK: - Public Properties

    var entry: StartPoint?

    // MARK: - Public Methods

    func start(id: Int) -> DetailsRouterProtocol {
        let router = DetailsRouter()
        let presenter = DetailsPresenter()
        let interaсtor: DetailsInteractorProtocol = DetailsInteractor(presenter: presenter)
        presenter.detailsInteractor = interaсtor
        presenter.detailsRouter = router


        let detailsView = DetailsView(presenter: presenter)
        let hostingController = UIHostingController(rootView: detailsView)
        presenter.id = id
        router.entry = hostingController
        return router
    }

    func goBack() {
        entry?.navigationController?.popViewController(animated: true)
    }
}
