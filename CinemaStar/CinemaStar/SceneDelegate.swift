// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureSceneDelegate(windowScene: windowScene)
    }

    private func configureSceneDelegate(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        showCatalogFilms()
    }

    private func showCatalogFilms() {
        let catalogRouter = ListRouter().start()
        guard let catalogEntry = catalogRouter.entry else { return }
        let rootViewController = UINavigationController(rootViewController: catalogEntry)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
