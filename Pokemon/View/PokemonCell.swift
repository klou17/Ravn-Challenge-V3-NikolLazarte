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
                spriteFront
                nameAndID
                types
            }
            .padding(.horizontal, 10)
        }
        .padding([.leading, .trailing], 24)
    }
    
    private var cellBackground: some View {
        RoundedRectangle(cornerRadius: Constants.ListCell.cornerRadius)
            .foregroundColor(.cellBackground)
    }
    
    private var nameAndID: some View {
        VStack {
            Text(pokemon.name.capitalized)
                .font(.body)
                .fontWeight(.semibold)
            Text("#" + String(format: "%03d", pokemon.id))
                
        }
    }
    
    private var spriteFront: some View {
        AsyncImage(url: pokemon.frontDefaultSprite) { image in image.resizable()
        } placeholder: {
            Color.red
        }
        .frame(width: 100, height: 100)
        .padding(.leading, -40)
    }
    
    private var types: some View {
        ForEach(pokemon.types) { type in
            Image("\(type)Icon")
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

struct PokemonCell_Previews: PreviewProvider {
    
    static let pokemon = Pokemon(id: 1, name: "bulbasaur", frontDefaultSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), frontShinySprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"), generation: "Generation I", types: ["Grass", "Poison"])
    
    static var previews: some View {
        PokemonCell(pokemon: pokemon)
.previewInterfaceOrientation(.portrait)
    }
}
