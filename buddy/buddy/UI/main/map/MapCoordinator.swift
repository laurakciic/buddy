//
//  MapCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI

final class MapCoordinator: Coordinator {

    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        return createMapViewController()
    }

    func createMapViewController() -> UIViewController {
        let mapVM = MapViewModel()
        let mapVC = UIHostingController(rootView: MapView(viewModel: mapVM))
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))

        return mapVC
    }
}
