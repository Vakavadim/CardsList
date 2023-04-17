//
//  SceneDelegate.swift
//  CardsList
//
//  Created by Вадим Гамзаев on 15.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)

		window.rootViewController = UINavigationController(rootViewController: assembly())
		window.makeKeyAndVisible()
				
		self.window = window
	}
	
	func assembly() -> UIViewController {
//		let networkManager = NetworkManager()
		let cardsListViewController = CardsListViewController()
		return cardsListViewController
	}
}
