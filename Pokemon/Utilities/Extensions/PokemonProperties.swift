//
//  PokemonProperties.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

extension Pokemon {
    var namePokemon: String {
        name ?? ""
    }
    
    var idPokemon: String {
        return "#" + (number ?? "")
    }
    
    var classificationPokemon: String {
        classification ?? ""
    }
    
    var spriteFrontDefaultImage: URL? {
        URL(string: image ?? "")
    }
    
    var typesPokemon: [String] {
        guard let types = types else { return [] }
        return types.compactMap { $0 }
    }
    
    var idInt: Int {
        guard let id = number else { return 0 }
        return Int(id) ?? 0
    }
    
    var evolutionsPokemon: [String] {
        guard let evolutions = evolutions else { return [] }
        return evolutions.compactMap { $0?.name }
    }
}
