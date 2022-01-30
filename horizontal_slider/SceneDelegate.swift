//
//  SceneDelegate.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        setupGameMapController(scene: scene)
    }

    private func setupGameMapController(scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = GameMapViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

