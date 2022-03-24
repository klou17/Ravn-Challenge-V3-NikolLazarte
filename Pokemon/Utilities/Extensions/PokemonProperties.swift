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
        return "#" + String(format: "%03d", idInt)
    }
    
    var spriteFrontDefaultImage: URL? {
        URL(string: sprites?.frontDefault ?? "")
    }
    
    var spriteFrontShinyImage: URL? {
        URL(string: sprites?.frontShiny ?? "")
    }
    
    var generationPokemons: String {
        generation ?? ""
    }
    
    var colorPokemon: String {
        color ?? ""
    }
    
    private var idInt: Int {
        return Int(id ?? 0)
    }
    
}
