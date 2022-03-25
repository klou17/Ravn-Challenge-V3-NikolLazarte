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
            url: viewModel.getSprite(pokemon: viewModel.pokemon),
            width: Constants.DetailView.sizeSpriteFront,
            height: Constants.DetailView.sizeSpriteFront
        )
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
                Text(viewModel.pokemon.idPokemon + " " + viewModel.pokemon.namePokemon)
                    .font(.title)
                    .padding(.top, Constants.DetailView.paddingNameId)
                
                types
                
                Text(viewModel.pokemon.classificationPokemon)
                    .font(.body)
                
                Text(viewModel.pokemonDescription)
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(17)
                
                DividerCustom()
                
                evolutions
            }
        }
    }
    
    private var evolutions: some View {
        Group {
            Text("Evolutions")
                .font(.title3)
            HStack {
//                ForEach(viewModel.pokemon.evolutionPokemon, id: \.self) { evolution in
//                    Text("\(evolution)")
//                }
            }
        }
    }
    
    private func evolutionItem(for pokemon: Pokemon) -> some View {
        VStack {
            AsyncImage(url: pokemon.spriteFrontDefaultImage)
                .frame(width: 80, height: 80)
                .overlay {
                    Circle().background(.gray)
                }
            Text(pokemon.namePokemon)
                .fontWeight(.semibold)

            Text(pokemon.idPokemon)
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetailView(viewModel: .init(pokemon: Pokemon(id: 3, name: "bulbasur", generation: "Generation 1", sprites: Pokemon.Sprite.init(frontDefault: "", frontShiny: ""))))
//    }
//}
