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
            .padding(.horizontal, Constants.ListCell.paddingInfoCell)
        }
        .padding(.leading, Constants.ListCell.paddingLeadingCell)
        .padding(.trailing, Constants.ListCell.paddingTrailingCell)
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
            Text(pokemon.idPokemon)
        }
    }
    
    private var spriteFrontImage: some View {
        AsyncImageCustom (
            url: pokemon.spriteFrontDefaultImage,
            width: Constants.ListCell.sizeSprite,
            height: Constants.ListCell.sizeSprite
        )
            .padding(.leading, Constants.ListCell.paddingLeadingSprite)
            .padding(.trailing, Constants.ListCell.paddingTrailingSprite)
    }
    
    private var types: some View {
        ForEach(pokemon.typesPokemon) { type in
            Image("\(type)Icon")
                .resizable()
                .frame(width: Constants.ListCell.sizeType, height: Constants.ListCell.sizeType)
                .padding(.trailing, Constants.ListCell.paddingTrailingType)
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
