//
//  PokemonDetailServiceMock.swift
//  PokemonTests
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation
import Apollo
import Combine
@testable import Pokemon

class PokemonDetailServiceMock: PokemonDetailServiceType {
    var result: MockResult
    
    init(result: MockResult = .success) {
        self.result = result
    }
    
    func fetchSpeciesDetail(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        if result == .failure {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        } else {
            let pokemonSpecie = PokemonSpeciesResponse(
                flavorTextEntries:[PokemonSpeciesResponse.Flavor(flavorText: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokemon.", language: PokemonSpeciesResponse.Language(name: "en"))], color: PokemonSpeciesResponse.Color(name: "green"))
            return Just(pokemonSpecie)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchSpritesDetail(id: Int) -> AnyPublisher<PokemonSpritesResponse, Error> {
        if result == .failure {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        } else {
            let pokemonSprite = PokemonSpritesResponse(sprites: PokemonSpritesResponse.Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"))
            
            return Just(pokemonSprite)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

