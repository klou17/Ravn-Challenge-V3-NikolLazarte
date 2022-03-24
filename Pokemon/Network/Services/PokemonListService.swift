//
//  PokemonListService.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 22/03/22.
//

import Foundation
import Combine

protocol PokemonListServiceType {
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error>
    
}

typealias Pokemon = GetAllPokemonsQuery.Data.AllPokemon
struct PokemonListService: PokemonListServiceType {
    private let network: Network
    
    init(network: Network = Network.shared){
        self.network = network
    }
    
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error> {
        network.fetch(GetAllPokemonsQuery())
            .compactMap { $0.allPokemon?.compactMap{ $0 } }
            .mapError { _ in NetworkError.failLoadData}
            .eraseToAnyPublisher()
    }
}
