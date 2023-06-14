//
//  ProfileCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI
import UIKit

final class ProfileCoordinator: Coordinator {
    
    weak var rootCoordinator: RootCoordinator?
    private var navigationController = UINavigationController()
    
    init(rootCoordinator: RootCoordinator) {
        self.rootCoordinator = rootCoordinator
    }
    
    @MainActor func start() -> UIViewController {
        return createProfileViewController()
    }

    @MainActor func createProfileViewController() -> UIViewController {
        let profileVM = ProfileViewModel()
        let authVM = AuthenticationViewModel(persistenceService: PersistenceService())

        let profileVC = UIHostingController(rootView: ProfileView(authVM: authVM, profileVM: profileVM))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        profileVM.goToAuth = { [weak self] in
            self?.goToAuthentication()
        }
        
        navigationController.setViewControllers([profileVC], animated: true)
        return navigationController
    }
    
    @MainActor private func goToAuthentication() {
        guard let rootCoordinator = rootCoordinator else {
            fatalError("Root Coordinator missing.")
        }

        /** same reason as previously, no need to add rootVC to navigation stack because we are completely switching flows */
        _ = rootCoordinator.start()
    }
    
    deinit {
        print("Profile Coordinator deinitialized")
    }
}
