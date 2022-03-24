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
            VStack(spacing: .zero) {
                Divider()
                    .background(.ultraThinMaterial)
                listPokemons
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Pokemon List")
                            .font(.largeTitle.bold())
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(.cellBackground)
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        }
    }
    
    private var listPokemons: some View {
        ScrollView {
            ForEach(viewModel.pokemons, id:\.id) { pokemon in
                NavigationLink {
                    PokemonDetailView(viewModel: PokemonDetailViewModel(
                        pokemon: pokemon
                    ))
                } label: {
                    PokemonCell(pokemon: pokemon)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
