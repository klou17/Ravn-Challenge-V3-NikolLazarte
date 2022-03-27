//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    enum Constants {
        static let sizeSpriteFront: CGFloat = 150
        static let cornerRadiusBgBody: CGFloat = 30
        static let paddingTopBody: CGFloat = 10
        static let widthType: CGFloat = 130
        static let heightType: CGFloat = 50
        static let paddingPicker: CGFloat = 18
        static let paddingNameId: CGFloat = 15
        static let paddingGeneration: CGFloat = 8
        static let radiusImage: CGFloat = 7
        static let paddingDescription: CGFloat = 17
        static let paddingEvolutionItem: CGFloat = 20
        static let sizeEvolutionImage: CGFloat = 75
    }
    
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
                .padding(.top, Constants.paddingTopBody)
            }
        }
        .navigationTitle("Pokemon Info")
    }
    
    private var imagePokemon: some View {
        AsyncImageCustom(url: viewModel.urlSprite)
            .frame(width: Constants.sizeSpriteFront, height: Constants.sizeSpriteFront)
            .shadow(color: .gray, radius: Constants.radiusImage, x: 0, y: 0)
            .padding()
    }
    
    private var types: some View {
        HStack {
            ForEach(viewModel.pokemon.typesPokemon) { type in
                Image("\(type)")
                    .resizable()
                    .frame(width: Constants.widthType, height: Constants.heightType)
            }
        }
    }
    
    private var pickerSprites: some View {
        Picker("Active Sprite", selection: $viewModel.activeSprite) {
            Text("Default Sprite").tag(0)
            Text("Shiny Sprite").tag(1)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, Constants.paddingPicker)
    }
    
    private var backgroundBody: some View {
        Color.systemBackground
            .cornerRadius(Constants.cornerRadiusBgBody, corners: [.topLeft, .topRight])
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
            .padding(.top, Constants.paddingNameId)
    }
    
    private var classification: some View {
        Text(viewModel.pokemon.classificationPokemon)
            .font(.body)
    }
    
    private var description: some View {
        Text(viewModel.pokemonDescription)
            .multilineTextAlignment(.center)
            .font(.footnote)
            .padding(Constants.paddingDescription)
    }
    
    private var evolutions: some View {
        Group {
            if !(viewModel.getEvolutions(pokemon: viewModel.pokemon)?.isEmpty ?? true) {
                DividerCustom()
                
                Text("Evolutions")
                    .font(.title3)
                VStack {
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
                .padding(.horizontal, Constants.paddingEvolutionItem)
            
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
            Circle()
                .fill()
                .foregroundColor(.gray)
                .overlay {
                    AsyncImageCustom(url: viewModel.getSprite(pokemon: pokemon))
                }
                .frame(width: Constants.sizeEvolutionImage, height: Constants.sizeEvolutionImage)
            Text(pokemon.namePokemon)
                .fontWeight(.semibold)
            Text(pokemon.idPokemon)
        }
    }
}

