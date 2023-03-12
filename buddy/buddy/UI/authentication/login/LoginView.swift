//
//  LoginView.swift
//  buddy
//
//  Created by Laura on 05.03.2023..
//

import SwiftUI
import Combine

private enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    
    @ObservedObject var viewModel = AuthenticationViewModel()
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    @State private var isPasswordVisible: Bool = false
    
    private func loginWithEmailPassword() {
        Task {
            if await viewModel.loginWithEmailPassword() == true {
                onAuthenticatedGoToMain?()
                dismiss()
            }
        }
    }
    
    var onAuthenticatedGoToMain: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Image("pets")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                
                Spacer()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.1)
            .padding(.bottom, 30)
            .background(Color.darkPurple)
            
            HStack(spacing: 0) {
                Spacer()
                
                HStack() {
                    Text(" Sign in")
                        .foregroundColor(.lilac)
                    Text("to find buddies!")
                        .foregroundColor(.darkPurple)
                }
                .padding()
                .font(.title2)
                .fontWeight(.bold)
                .background(.white)
                .padding(.bottom, 15)
                .cornerRadius(15)
                .padding(.bottom, -15)
                
                Spacer()
            }
            .background(Color.darkPurple)
            
            VStack{
                HStack {
                    TextField("Email Address", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .password
                        }
                    
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.lilac)
                }
                Divider().background(.opacity(0.5))
                
                HStack {
                    ZStack {
                        SecureField("Password", text: $viewModel.password)
                            .focused($focus, equals: .password)
                            .submitLabel(.go)
                            .opacity(isPasswordVisible ? 0 : 1)
                        
                        TextField("Password", text: $viewModel.password)
                            .focused($focus, equals: .password)
                            .submitLabel(.go)
                            .opacity(isPasswordVisible ? 1 : 0)
                    }
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        loginWithEmailPassword()
                    }
                    
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.lilac)
                        .onTapGesture {
                            self.isPasswordVisible.toggle()
                        }
                }
                .padding(.top, 30)
                Divider().background(.opacity(0.5))
            }
            .padding(.horizontal, 40)
            .padding(.top, 40)
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color(UIColor.systemRed))
                }
                .padding(.top)
            }
            
            Button(action: loginWithEmailPassword) {
                if viewModel.authenticationState != .authenticating {
                  Text("Sign in")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 130)
                    .background(Color.darkPurple)
                    .clipShape(Capsule())
                }
                else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                      .fontWeight(.bold)
                      .padding(.vertical, 10)
                      .padding(.horizontal, 130)
                      .background(Color.darkPurple)
                      .clipShape(Capsule())
                }
            }
            .padding(.top, 50)
            
            Spacer()
            
            VStack {
                Text("Don't have an account?")
                    .foregroundColor(.darkPurple)
                    .fontWeight(.light)
                
                Button(action: { viewModel.switchFlow() }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 65)
                        .background(Color.lilac)
                        .clipShape(Capsule())
                }
            }
            .padding([.top, .bottom])
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: AuthenticationViewModel())
    }
}
