//
//  PersistenceService.swift
//  buddy
//
//  Created by Laura on 03.04.2023..
//

import Foundation
import FirebaseAuth

final class PersistenceService {
    
    var isLoggedIn: Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    var displayName = ""
    var user: User?
    
    init() {
        registerAuthStateHandler()
    }
    
    // MARK: - Reflecting login state managed by Firebase
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                self?.user = user
                self?.displayName = user?.email ?? ""
            }
        }
    }
}
