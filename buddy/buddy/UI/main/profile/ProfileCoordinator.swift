//
//  ProfileCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI
import UIKit

final class ProfileCoordinator: Coordinator {
    
    private var navigationController = UINavigationController()

    @MainActor func start() -> UIViewController {
        return createProfileViewController()
    }

    @MainActor func createProfileViewController() -> UIViewController {
        let profileVM = ProfileViewModel()
        let authVM = AuthenticationViewModel()

        let profileVC = UIHostingController(rootView: ProfileView(authVM: authVM, profileVM: profileVM))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        profileVM.goToAuth = {
            self.goToAuthentication()
        }
        
        navigationController.setViewControllers([profileVC], animated: true)
        return navigationController
    }
    
    @MainActor private func goToAuthentication() {
        let authCoordinator = AuthenticationCoordinator()
        let authVC = authCoordinator.start()

        authVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(authVC, animated: true)
    }
}
