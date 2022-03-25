//
//  AllPokemon+Hashable.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation

extension Pokemon: Equatable {
    public static func == (lhs: GetAllPokemonsQuery.Data.AllPokemon, rhs: GetAllPokemonsQuery.Data.AllPokemon) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
}

extension Pokemon: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//extension Pokemon: Comparable {
//    public static func < (lhs: GetAllPokemonsQuery.Data.AllPokemon, rhs: GetAllPokemonsQuery.Data.AllPokemon) -> Bool {
//        lhs.generationPokemon < rhs.generationPokemon
//    }
//
//    public static func > (lhs: GetAllPokemonsQuery.Data.AllPokemon, rhs: GetAllPokemonsQuery.Data.AllPokemon) -> Bool {
//        lhs.generationPokemon > rhs.generationPokemon
//    }
//}
