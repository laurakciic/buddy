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
        return navigationController
    }
    
    private func callRoot() {
        guard let rootCoordinator = parentCoordinator else { fatalError("Parent coordinator is missing.") }
        
        let parentVC = rootCoordinator.start()

        parentVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(parentVC, animated: true)
    }
    
    deinit {
        print("Authentication coordinator deinitialized")
    }
}
