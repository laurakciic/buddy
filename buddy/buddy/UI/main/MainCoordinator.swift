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
    weak var parentCoordinator: RootCoordinator?

    func start() -> UIViewController {
        return startTabBar()
    }

    func startTabBar() -> UINavigationController {
        guard let rootCoordinator = parentCoordinator else { fatalError("Parent coordinator is missing.") }
        
        childCoordinators = [
            MapCoordinator(navigationController: navigationController),
            ProfileCoordinator(rootCoordinator: rootCoordinator)
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
    
    deinit {
        print("Main coordinator deinitialized")
    }
}
