//
//  SceneDelegate.swift
//  test int
//
//  Created by Артём Скрипкин on 21.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: ViewController())
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }

}

