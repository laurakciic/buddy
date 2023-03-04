//
//  MainCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import UIKit

final class MainCoordinator: Coordinator {

    private var navigationController = UINavigationController()
    private var tabBarController = UITabBarController()
    private var childCoordinators = [Coordinator]()

    func start() -> UIViewController {
        return startTabBar()
    }

    func startTabBar() -> UINavigationController {
        childCoordinators = [
            MapCoordinator(navigationController: navigationController),
            ProfileCoordinator()
        ]

        createTabBar()
        navigationController.viewControllers = [tabBarController]
        return navigationController
    }

    func createTabBar() {
        tabBarController = UITabBarController()

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearance

        tabBarController.tabBar.tintColor = .darkGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = childCoordinators.map { coordinator in
            coordinator.start()
        }
    }
}
