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
    
    func start() -> UIViewController {
        return showAuthentication()
    }
    
    func showAuthentication() -> UIViewController {
        let authVM = AuthenticationViewModel()
        let authVC = UIHostingController(rootView: AuthenticationView(viewModel: authVM))
        
        return authVC
    }
}
