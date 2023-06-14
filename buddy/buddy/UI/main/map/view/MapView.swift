//
//  MapView.swift
//  buddy
//
//  Created by Laura on 04.03.2023..
//

import SwiftUI

struct MapView: View {

    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        Text("Map")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel())
    }
}
