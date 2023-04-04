//
//  PersistenceService.swift
//  buddy
//
//  Created by Laura on 03.04.2023..
//

import Foundation
import FirebaseAuth


final class PersistenceService: PersistenceServiceProtocol {
    
    var isLoggedIn: Bool = false
    var displayName = ""
    var user: User?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.isLoggedIn = isUserLoggedIn()
        registerAuthStateHandler()
    }
    
    private func isUserLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Reflecting login state managed by Firebase
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.displayName = user?.email ?? ""
            }
        }
    }
}
