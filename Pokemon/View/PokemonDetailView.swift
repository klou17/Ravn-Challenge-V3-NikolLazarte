//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import SwiftUI
typealias PokemonType = GetAllPokemonsQuery.Data.AllPokemon.Type
struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        ZStack {
            Color(viewModel.pokemon.colorPokemon)
            
            VStack(spacing: .zero) {
                AsyncImage(url: viewModel.pokemon.spriteFrontDefaultImage) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                Picker("Active Sprite", selection: $viewModel.activeSprite) {
                    Text("Default Sprite").tag(0)
                    Text("Shiny Sprite").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                
                ZStack {
                    Color.systemBackground
                        .cornerRadius(40, corners: [.topLeft, .topRight])
                    VStack {
                        Text(viewModel.pokemon.idPokemon + " " + viewModel.pokemon.namePokemon)
                            .font(.title)
                        types
                        
                        Text(viewModel.pokemon.generationPokemons)
                            .font(.body)
                            .padding(.bottom, 8)
                    }
                }
                .padding(.top, 10)
            }
        }
        .navigationTitle("Pokemon Info")
    }
    
    private var types: some View {
        HStack {
            ForEach(viewModel.pokemon.typesPokemon) { type in
                Image("\(type)")
                    .resizable()
                    .frame(width: 100, height: 50)
            }
        }
    }
}
