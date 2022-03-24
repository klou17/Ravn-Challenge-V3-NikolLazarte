//
//  PokemonDetailResponse.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let color: Color
    
    
    struct Color: Codable, Equatable {
        let name: String
    }

}
