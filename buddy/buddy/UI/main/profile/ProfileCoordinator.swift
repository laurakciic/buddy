//
//  ProfileCoordinator.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI

final class ProfileCoordinator: Coordinator {

    func start() -> UIViewController {
        return createProfileViewController()
    }

    func createProfileViewController() -> UIViewController {
        let profileVM = ProfileViewModel()
        let profileVC = UIHostingController(rootView: ProfileView(viewModel: profileVM))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        return profileVC
    }
}
