//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import SwiftUI

struct PokemonCell: View {
    let pokemon: Pokemon
    
    var body: some View {
        ZStack {
            cellBackground
            
            HStack(spacing: .zero) {
                spriteFrontImage
                nameAndID
                Spacer()
                types
            }
            .padding(.horizontal, 8)
        }
        .padding(.leading, 48)
        .padding(.trailing, 24)
    }
    
    private var cellBackground: some View {
        RoundedRectangle(cornerRadius: Constants.ListCell.cornerRadius)
            .foregroundColor(.cellBackground)
    }
    
    private var nameAndID: some View {
        VStack(alignment: .leading) {
            Text(pokemon.namePokemon)
                .font(.body)
                .fontWeight(.semibold)
            Text("#" + pokemon.idPokemon)
        }
    }
    
    private var spriteFrontImage: some View {
        AsyncImage(url: pokemon.spriteImage) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 80, height: 80)
        .padding(.leading, -40)
        .padding(.trailing, 10)
    }
    
    private var types: some View {
        ForEach(pokemon.typesPokemon) { type in
            Image("\(type)Icon")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, -5)
        }
    }
}

//struct PokemonCell_Previews: PreviewProvider {
//
//    static let pokemon = Pokemon(id: 1, name: "bulbasaur", frontDefaultSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), frontShinySprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"), generation: "Generation I", types: [TypePokemon(name: "Grass"), TypePokemon(name: "Poison")])
//
//    static var previews: some View {
//        PokemonCell(pokemon: pokemon)
//.previewInterfaceOrientation(.portrait)
//    }
//}
