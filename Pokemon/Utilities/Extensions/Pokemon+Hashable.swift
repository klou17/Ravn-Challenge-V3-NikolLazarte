//
//  AllPokemon+Hashable.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

extension Pokemon: Equatable {
    public static func == (lhs: GetAllPokemonsQuery.Data.Pokemon, rhs: GetAllPokemonsQuery.Data.Pokemon) -> Bool {
        lhs.number == rhs.number &&
        lhs.name == rhs.name
    }
}

extension Pokemon: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }
}
