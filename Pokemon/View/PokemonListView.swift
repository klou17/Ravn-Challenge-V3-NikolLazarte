//
//  ContentView.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var searchText = ""
    var body: some View {
        NavigationView {
            List {

            }
            .navigationTitle("Pokemon List")
        }
        .searchable(text: $searchText) {
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
