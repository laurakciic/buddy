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
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var isValid = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var displayName = ""
    
    var onAuthenticatedGoToMain: (() -> Void)?
    
    init() {
        registerAuthStateHandler()
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    // Firebase maintains login state, here we are reflecting it in the application state
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
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
            try await Auth.auth().createUser(withEmail: email, password: password)
            return true
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
            try Auth.auth().signOut()   // await not necessary since signing out does not require reaching to backend (only resetting local auth state)
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
