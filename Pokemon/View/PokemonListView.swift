//
//  ContentView.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pokemons, id:\.id) { pokemon in
                    PokemonCell(pokemon: pokemon)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Pokemon List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
