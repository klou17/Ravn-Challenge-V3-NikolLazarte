//
//  PokemonProperties.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

extension Pokemon {
    var typesPokemon: [String] {
        guard let types = types else { return [] }
        return types.compactMap { $0?.name }
    }
    
    var namePokemon: String {
        name?.capitalized ?? ""
    }
    
    var idPokemon: String {
        return id?.formatted() ?? ""
    }
    
    var spriteImage: URL? {
        URL(string: sprites?.frontDefault ?? "")
    }
    
    var generationPokemons: String {
        generation ?? ""
    }
}
