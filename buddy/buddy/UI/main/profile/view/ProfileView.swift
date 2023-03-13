//
//  ProfileView.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var authVM: AuthenticationViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    @State var presentingConfirmationDialog = false
    
    private func deleteAccount() {
        Task {
            if await authVM.deleteAccount() == true {
                profileVM.goToAuth?()
            }
        }
    }
    
    private func signOut() {
        authVM.signOut()
        profileVM.goToAuth?()
    }

    var body: some View {
        Form {
            Section("Email") {
                Text(authVM.displayName)
            }
            
            Section {
                Button(role: .cancel, action: signOut) {
                    HStack {
                        Spacer()
                        Text("Sign out")
                        Spacer()
                    }
                }
            }
            
            Section {
                Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                    HStack {
                        Spacer()
                        Text("Delete Account")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .confirmationDialog("Deleting your account is permanent. Do you want to proceed?", isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
            Button("Delete Account", role: .destructive, action: deleteAccount)
            Button("Cancel", role: .cancel, action: { })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authVM: AuthenticationViewModel(), profileVM: ProfileViewModel())
    }
}
