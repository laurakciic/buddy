//
//  ProfileViewModel.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import Foundation
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
    
    var goToAuth: (() -> Void)?
    
}
