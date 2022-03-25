//
//  PokemonDetailResponse.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let flavorTextEntries: [Flavor]
        
    struct Flavor: Codable {
        let flavorText: String
        let language: Language
    }
    
    struct Language: Codable {
        let name: String
    }
}
