//
//  AuthenticationView.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI

struct AuthenticationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Authentication")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: AuthenticationViewModel())
    }
}
