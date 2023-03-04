//
//  RootCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import UIKit

final class RootCoordinator: Coordinator {
    
    private var userLoggedIn: Bool = false
    private var childCoordinators: [Coordinator] = [AuthenticaionCoordinator(), MainCoordinator()]
    
    func start() -> UIViewController {
        if userLoggedIn {
            return childCoordinators[1].start()
        } else {
            return childCoordinators[0].start()
        }
    }
}

