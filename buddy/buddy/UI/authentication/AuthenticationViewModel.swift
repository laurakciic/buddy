//
//  AuthenticationViewModel.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case register
}

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    var onAuthenticatedGoToMain: (() -> Void)?
    var persistenceService: PersistenceService
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage = ""
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func switchFlow() {
        flow = flow == .login ? .register : .login
        errorMessage = ""
        email = ""
        password = ""
        confirmPassword = ""
    }
}

// MARK: - Email and Password Authentication

extension AuthenticationViewModel {
    
    func loginWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        
        do {
            try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func registerWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        
        do {
            if passwordsMatch(password, confirmPassword) {
                try await Auth.auth().createUser(withEmail: email, password: password)
                return true
            } else {
                authenticationState = .unauthenticated
                return false
            }
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signOut() {
        do {
            /** await not necessary since signing out does not require reaching to backend (only resetting local auth state) */
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await persistenceService.user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func passwordsMatch(_ password: String, _ confirmPassword: String) -> Bool {
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return false
        }
        return true
    }
}
