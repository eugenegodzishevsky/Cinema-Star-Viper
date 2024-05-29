// MovieCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол координатора  главного экрана
protocol MovieCoordinatorProtocol {
    /// Замыкание, выполняющееся при выходе
    var onFinishFlow: VoidHandler? { get set }
    /// Корневой вью контроллер
    var rootController: UINavigationController? { get set }
    /// Функция установки рутового вью контроллера
    func setRootViewController(view: UIViewController, moduleBuilder: Builder)
    /// Функция перехода на экран деталей фильма
    func openMovieDetails(id: Int)
    /// Функция возврата на главный экран
    func returnToMainScreen()
}

/// Координатор  главного экрана
final class MainCoordinator: BaseCoordinator, MovieCoordinatorProtocol {
    // MARK: - Public Properties

    var onFinishFlow: VoidHandler?
    var rootController: UINavigationController?

    // MARK: - Private Properties

    private var moduleBuilder: Builder?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController, moduleBuilder: Builder) {
        rootController = UINavigationController(rootViewController: view)
        self.moduleBuilder = moduleBuilder
    }

    func openMovieDetails(id: Int) {
        let detailsView = moduleBuilder?.createDetailsModule(coordinator: self, id: id)
        guard let detailsView = detailsView else { return }
        rootController?.pushViewController(detailsView, animated: true)
    }

    func returnToMainScreen() {
        rootController?.navigationBar.isHidden = true
        rootController?.popViewController(animated: true)
    }
}
