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
                if viewModel.errorLoadData {
                    ProgressView()
                }
                VStack(spacing: .zero) {
                    DividerCustom()
                    listPokemons
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pokemon List")
                        .font(.largeTitle.bold())
                }
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .alert(item: $viewModel.errorMessage) { _ in
            Alert(
                title: Text(NetworkError.failLoadData.messageErrorTitle),
                message: Text(NetworkError.failLoadData.messageErrorBody),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(.cellBackground)
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            viewModel.subscriptions()
        }
    }
    
    private var listPokemons: some View {
        ScrollView {

            ForEach(viewModel.classifications) { classification in
                VStack(alignment: .leading, spacing: .zero) {
                    Text("\(classification)")
                        .font(.title3)
                        .padding(.bottom, 3)
                    DividerCustom()
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding(.horizontal, 20)
                
                ForEach(viewModel.pokemonsGroupSection[classification] ?? [], id: \.idInt) { pokemon in
                    NavigationLink {
                        PokemonDetailView(viewModel: PokemonDetailViewModel(
                            pokemon: pokemon
                        ))
                    } label: {
                        PokemonCell(pokemon: pokemon)
                            .padding(.bottom, 10)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
