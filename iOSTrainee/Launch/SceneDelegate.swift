//
//  SceneDelegate.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = MainViewController()

        let networkService = NetworkService()
        let presenter = MainPresenter(networkService: networkService)

        viewController.presenter = presenter
        presenter.view = viewController
        let navigationController = UINavigationController(rootViewController: viewController)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
