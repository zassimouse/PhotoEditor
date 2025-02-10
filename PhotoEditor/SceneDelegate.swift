//
//  SceneDelegate.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 3.02.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = EditorViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }

}

