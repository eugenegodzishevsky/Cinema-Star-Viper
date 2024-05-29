// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        createRootViewController(windowScene)
    }

    private func createRootViewController(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            let moduleBuilder = ModuleBuilder()
            appCoordinator = AppCoordinator(appBuilder: moduleBuilder)
            appCoordinator?.start()
        }
    }
}
