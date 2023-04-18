//
//  RootCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import UIKit

final class RootCoordinator: Coordinator {
    
    private var childCoordinator: Coordinator?
    private let persistanceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistanceService = persistenceService
    }
    
    func start() -> UIViewController {
        if persistanceService.isLoggedIn {
            let mainCoordinator = MainCoordinator()
            mainCoordinator.parentCoordinator = self
            childCoordinator = mainCoordinator
        } else {
            let authCoordinator = AuthenticationCoordinator()
            authCoordinator.parentCoordinator = self
            childCoordinator = authCoordinator
        }
        return childCoordinator!.start()
    }
    
    deinit {
        print("Root coordinator deinitialized")
    }
}

