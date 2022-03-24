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
            ZStack {
                listPokemons
                .navigationTitle("Pokemon List")
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            UINavigationBar.appearance().backgroundColor = UIColor(.cellBackground)
        }
    }
    
    private var listPokemons: some View {
        ScrollView {
            Divider()
                .background(.ultraThinMaterial)
            ForEach(viewModel.pokemons, id:\.id) { pokemon in
                NavigationLink {
                    PokemonDetailView()
                } label: {
                    PokemonCell(pokemon: pokemon)
                }
                .buttonStyle(.plain)
            }
        }
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
