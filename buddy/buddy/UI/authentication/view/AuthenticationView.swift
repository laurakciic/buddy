//
//  AuthenticationView.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI
import Combine

struct AuthenticationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            switch viewModel.flow {
            case .login:
                LoginView(viewModel: viewModel) {
                    viewModel.onAuthenticatedGoToMain?()
                }
            case .register:
                RegisterView(viewModel: viewModel) {
                    viewModel.onAuthenticatedGoToMain?()
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: AuthenticationViewModel())
    }
}
