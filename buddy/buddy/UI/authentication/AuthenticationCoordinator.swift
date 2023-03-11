//
//  AuthenticationCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import UIKit
import SwiftUI

final class AuthenticaionCoordinator: Coordinator {
    
    private var childCoordinator: Coordinator!
    private var navigationController = UINavigationController()
    
    @MainActor func start() -> UIViewController {
        return showAuthentication()
    }
    
    @MainActor func showAuthentication() -> UIViewController {
        let authVM = AuthenticationViewModel()
        let authVC = UIHostingController(rootView: AuthenticationView(viewModel: authVM))
                        
        authVM.onAuthenticatedGoToMain = { [weak self] in
            self?.goToMain()
        }
        
        navigationController.setViewControllers([authVC], animated: false)
        return navigationController
    }
    
    private func goToMain() {
        let mainCoordinator = MainCoordinator()
        let mainVC = mainCoordinator.start()
        
        mainVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(mainVC, animated: false)
    }
}
