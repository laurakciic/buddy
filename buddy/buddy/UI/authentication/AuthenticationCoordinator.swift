//
//  AuthenticationCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import UIKit
import SwiftUI

final class AuthenticationCoordinator: Coordinator {
    
    private var navigationController = UINavigationController()
    weak var parentCoordinator: RootCoordinator?
    
    @MainActor func start() -> UIViewController {
        return showAuthentication()
    }
    
    @MainActor func showAuthentication() -> UIViewController {
        let authVM = AuthenticationViewModel(persistenceService: PersistenceService())
        let authVC = UIHostingController(rootView: AuthenticationView(viewModel: authVM))
                        
        authVM.onAuthenticatedGoToMain = { [weak self] in
            self?.callRoot()
        }
        
        navigationController.setViewControllers([authVC], animated: true)
        
        /** By using showAsRoot() we remove any presented view controllers and navigationControllers from previous Coordinators,
         and we start a new flow -> therefore clearing the memory of any previous flows */
        navigationController.showAsRoot()
        
        return navigationController
    }
    
    private func callRoot() {
        guard let rootCoordinator = parentCoordinator else { fatalError("Parent Coordinator missing.") }
        
        /** We dont need to present from current navigationController, we just call the start method and the showAsRoot() method
         handles switching the rootViewController that is presented in the app */
        _ = rootCoordinator.start()
    }
    
    deinit {
        print("Authentication Coordinator deinitialized")
    }
}
