//
//  RootCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import UIKit
import FirebaseAuth

final class RootCoordinator: Coordinator {
    
    private var userLoggedIn: Bool = false
    private var childCoordinators: [Coordinator] = [AuthenticaionCoordinator(), MainCoordinator()]
    
    func start() -> UIViewController {
        checkUserAuthentication()
        if userLoggedIn {
            return childCoordinators[1].start()
        } else {
            return childCoordinators[0].start()
        }
    }
    
    private func checkUserAuthentication() {
        if Auth.auth().currentUser != nil {
            userLoggedIn = true
        } else {
            userLoggedIn = false
        }
    }
}

