//
//  SceneDelegate.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

        configureTabBarAppearance()
        configureNavigationBarAppearance()

        let coinsListController = CoinsListViewController()
        coinsListController.tabBarItem = UITabBarItem(title: "Coins", image: UIImage(systemName: "centsign.circle"), tag: 0)

        let favouriteCoinsController = FavouriteCoinsViewController()
        favouriteCoinsController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star.circle.fill"), tag: 1)

        let tabBarController = UITabBarController()
        let coinsListNavigationController = UINavigationController(rootViewController: coinsListController)
        let favouriteCoinsNavigationController = UINavigationController(rootViewController: favouriteCoinsController)
        tabBarController.viewControllers = [coinsListNavigationController, favouriteCoinsNavigationController]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBlack
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = .systemYellow
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBlack
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }
}
