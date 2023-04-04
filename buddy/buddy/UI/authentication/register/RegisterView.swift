//
//  RegisterView.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI
import Combine

private enum FocusableField: Hashable {
    case email
    case password
    case confirmPassword
}

struct RegisterView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    @FocusState private var focus: FocusableField?
    @State private var isPasswordVisible: Bool = false
    
    var onAuthenticatedGoToMain: (() -> Void)?
    
    private func registerWithEmailPassword() {
        Task {
            if await viewModel.registerWithEmailPassword() == true {
                onAuthenticatedGoToMain?()
            }
        }
    }
    
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
                
                HStack {
                    Text("Register")
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
                            .autocorrectionDisabled(true)
                            .focused($focus, equals: .password)
                            .submitLabel(.next)
                            .opacity(isPasswordVisible ? 0 : 1)
                        
                        TextField("Password", text: $viewModel.password)
                            .autocorrectionDisabled(true)
                            .focused($focus, equals: .password)
                            .submitLabel(.next)
                            .opacity(isPasswordVisible ? 1 : 0)
                    }
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        self.focus = .confirmPassword
                    }
                    
                    
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.lilac)
                        .onTapGesture {
                            self.isPasswordVisible.toggle()
                        }
                }
                .padding(.top, 30)
                Divider().background(.opacity(0.5))
                
                HStack {
                    ZStack {
                        SecureField("Confirm password", text: $viewModel.confirmPassword)
                            .autocorrectionDisabled(true)
                            .focused($focus, equals: .confirmPassword)
                            .submitLabel(.go)
                            .opacity(isPasswordVisible ? 0 : 1)
                            
                        
                        TextField("Confirm password", text: $viewModel.confirmPassword)
                            .autocorrectionDisabled(true)
                            .focused($focus, equals: .confirmPassword)
                            .submitLabel(.go)
                            .opacity(isPasswordVisible ? 1 : 0)
                    }
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        registerWithEmailPassword()
                        
                        if viewModel.authenticationState == .authenticated {
                            onAuthenticatedGoToMain?()
                        }
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
                .padding([.top, .horizontal])
            }
            
            Button(action: registerWithEmailPassword) {
                if viewModel.authenticationState != .authenticating {
                  Text("Register")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 130)
                    .background(Color.darkPurple)
                    .clipShape(Capsule())
                }
                else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .darkPurple))
                        .padding(.vertical, 10)
                }
            }
            .padding(.top, 50)
            
            Spacer()
            
            VStack {
                Text("Have an account?")
                    .foregroundColor(.darkPurple)
                    .fontWeight(.light)
                
                Button(action: { viewModel.switchFlow() }) {
                    Text("Sign In")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: AuthenticationViewModel())
    }
}
