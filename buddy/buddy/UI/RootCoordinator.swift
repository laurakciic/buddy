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
    
    init() {
        self.persistanceService = PersistenceService()
    }
    
    func start() -> UIViewController {
        if persistanceService.isLoggedIn {
            childCoordinator = MainCoordinator()
        } else {
            childCoordinator = AuthenticationCoordinator()
        }
        return childCoordinator!.start()
    }
}

