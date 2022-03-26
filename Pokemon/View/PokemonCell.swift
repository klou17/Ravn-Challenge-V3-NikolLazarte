//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import SwiftUI

struct PokemonCell: View {
    let pokemon: Pokemon
    
    enum Constants {
        static let cornerRadius = 16.0
        static let sizeSprite: CGFloat = 65
        static let sizeType: CGFloat = 50
        static let paddingLeadingSprite: CGFloat = -40
        static let paddingTrailingSprite: CGFloat = 10
        static let paddingTrailingType: CGFloat = -5
        static let paddingTrailingCell: CGFloat = 24
        static let paddingLeadingCell: CGFloat = 48
        static let paddingInfoCell: CGFloat = 12
        static let paddingLeadingName: CGFloat = 7
        static let radiusImage: CGFloat = 7
    }
    
    var body: some View {
        ZStack {
            cellBackground
            
            HStack(spacing: .zero) {
                spriteFrontImage
                nameAndID
                Spacer()
                types
            }
            .padding(.horizontal, Constants.paddingInfoCell)
        }
        .padding(.leading, Constants.paddingLeadingCell)
        .padding(.trailing, Constants.paddingTrailingCell)
    }
    
    private var cellBackground: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .foregroundColor(.cellBackground)
    }
    
    private var nameAndID: some View {
        VStack(alignment: .leading) {
            Text(pokemon.namePokemon)
                .font(.body)
                .fontWeight(.semibold)
            Text(pokemon.idPokemon)
        }
        .padding(.leading, Constants.paddingLeadingName)
    }
    
    private var spriteFrontImage: some View {
        AsyncImageCustom(url: pokemon.spriteFrontDefaultImage)
            .frame(width: Constants.sizeSprite, height: Constants.sizeSprite)
            .shadow(color: .gray, radius: Constants.radiusImage, x: 0, y: 0)
            .padding(.leading, Constants.paddingLeadingSprite)
            .padding(.trailing, Constants.paddingTrailingSprite)
    }
    
    private var types: some View {
        ForEach(pokemon.typesPokemon) { type in
            Image("\(type)Icon")
                .resizable()
                .frame(width: Constants.sizeType, height: Constants.sizeType)
                .padding(.trailing, Constants.paddingTrailingType)
        }
    }
}

