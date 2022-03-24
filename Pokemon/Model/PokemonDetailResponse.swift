//
//  PokemonDetailResponse.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let flavours: Flavour
        
    struct Flavour: Codable {
        let name: String
    }
}
