//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        ZStack {
            Color(viewModel.pokemonColor)
            
            VStack(spacing: .zero) {
                imagePokemon
                pickerSprites
                
                ZStack {
                    backgroundBody
                    detailPokemon
                }
                .padding(.top, Constants.DetailView.paddingTopBody)
            }
        }
        .navigationTitle("Pokemon Info")
    }
    
    private var imagePokemon: some View {
        AsyncImageCustom (
            url: viewModel.urlSprite,
            width: Constants.DetailView.sizeSpriteFront,
            height: Constants.DetailView.sizeSpriteFront
        )
            .padding()
    }
    
    private var types: some View {
        HStack {
            ForEach(viewModel.pokemon.typesPokemon) { type in
                Image("\(type)")
                    .resizable()
                    .frame(width: Constants.DetailView.widthType, height: Constants.DetailView.heightType)
            }
        }
    }
    
    private var pickerSprites: some View {
        Picker("Active Sprite", selection: $viewModel.activeSprite) {
            Text("Default Sprite").tag(0)
            Text("Shiny Sprite").tag(1)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, Constants.DetailView.paddingPicker)
    }
    
    private var backgroundBody: some View {
        Color.systemBackground
            .cornerRadius(Constants.DetailView.cornerRadiusBgBody, corners: [.topLeft, .topRight])
    }
    
    private var detailPokemon: some View {
        ScrollView {
            VStack {
                nameAndId
                types
                classification
                description
                evolutions
            }
        }
    }
    
    private var nameAndId: some View {
        Text(viewModel.pokemon.idPokemon + " " + viewModel.pokemon.namePokemon)
            .font(.title)
            .padding(.top, Constants.DetailView.paddingNameId)
    }
    
    private var classification: some View {
        Text(viewModel.pokemon.classificationPokemon)
            .font(.body)
    }
    
    private var description: some View {
        Text(viewModel.pokemonDescription)
            .multilineTextAlignment(.center)
            .font(.footnote)
            .padding(17)
    }
    
    private var evolutions: some View {
        Group {
            if !(viewModel.getEvolutions(pokemon: viewModel.pokemon)?.isEmpty ?? true) {
                DividerCustom()
                
                Text("Evolutions")
                    .font(.title3)
                HStack {
                    ForEach(viewModel.getEvolutions(pokemon: viewModel.pokemon) ?? [], id: \.namePokemon) { evolution in
                        evolutionItem(for: evolution)
                    }
                }
            }
            
        }
    }
    
    private func evolutionItem(for pokemon: Pokemon) -> some View {
        HStack {
            evolutionDetail(pokemon: viewModel.pokemon)
            
            Image(systemName: "arrow.right")
            
            NavigationLink {
                PokemonDetailView(viewModel: PokemonDetailViewModel(
                    pokemon: pokemon, evolutions: viewModel.getEvolutions(pokemon: pokemon)
                ))
            } label: {
                evolutionDetail(pokemon: pokemon)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private func evolutionDetail(pokemon: Pokemon) -> some View {
        VStack {
            AsyncImageCustom(
                url: viewModel.getSprite(pokemon: pokemon),
                width: 50,
                height: 50
            )
            Text(pokemon.namePokemon)
                .fontWeight(.semibold)

            Text(pokemon.idPokemon)
        }
    }
}
