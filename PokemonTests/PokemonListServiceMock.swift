//
//  PokemonListServiceMock.swift
//  PokemonTests
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation
import Apollo
import Combine
@testable import Pokemon

class PokemonListServiceMock: PokemonListServiceType {
    var result: MockResult
    
    init(result: MockResult = .success) {
        self.result = result
    }
    
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error> {
        if result == .failure {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        } else {
            let pokemons = [Pokemon(number: "001", name: "Bulbasaur", classification: "Seed Pokémon", types: ["Grass", "Poison"], evolutions: [GetAllPokemonsQuery.Data.Pokemon.Evolution(number: "002", name: "Ivysaur"), GetAllPokemonsQuery.Data.Pokemon.Evolution(number: "003", name: "Venusaur")], image: "https://img.pokemondb.net/artwork/bulbasaur.jpg")]
            print("poke \(pokemons)")
            return Just(pokemons)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    
}
