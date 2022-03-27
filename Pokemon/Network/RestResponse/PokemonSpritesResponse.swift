//
//  PokemonSpritesResponse.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation

struct PokemonSpritesResponse: Codable {
    let sprites: Sprites
    
    struct Sprites: Codable {
        let frontDefault: String
        let frontShiny: String
    }
}
