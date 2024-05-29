// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    private var appBuilder: Builder

    // MARK: - Public Methods

    override func start() {
        toMain()
    }

    // MARK: - Initializers

    init(appBuilder: Builder) {
        self.appBuilder = appBuilder
    }

    // MARK: - Private Methods

    private func toMain() {
        let mainCoordinator = MainCoordinator()
        let mainView = appBuilder.createMainModule(coordinator: mainCoordinator)
        mainCoordinator.setRootViewController(view: mainView, moduleBuilder: appBuilder)
        add(coordinator: mainCoordinator)
        setAsRoot(mainCoordinator.rootController ?? UINavigationController())
    }
}
