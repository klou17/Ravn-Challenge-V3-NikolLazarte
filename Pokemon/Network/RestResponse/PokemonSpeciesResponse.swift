//
//  PokemonDetailResponse.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

struct PokemonSpeciesResponse: Codable {
    let flavorTextEntries: [Flavor]
    let color: Color
    
    struct Flavor: Codable {
        let flavorText: String
        let language: Language
    }
    
    struct Language: Codable {
        let name: String
    }
    
    struct Color: Codable {
        let name: String
    }
}
