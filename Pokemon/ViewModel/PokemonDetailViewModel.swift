//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var activeSprite = 0
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
