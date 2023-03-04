//
//  ProfileView.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI

import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        Text("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
