//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation
import Combine
import Apollo
@testable import Pokemon

enum MockResult {
    case failure
    case success
    case delayed
}

class NetworkMock: NetworkServiceType {
    var result = MockResult.success
    
    init(result: MockResult) {
        self.result = result
    }
    
    func fetch<T>(_ query: T) -> AnyPublisher<T.Data, Error> where T : GraphQLQuery {
        let pokemon = GetAllPokemonsQuery.Data.Pokemon(number: "001", name: "Bulbasur", classification: "", types: [""], evolutions: [GetAllPokemonsQuery.Data.Pokemon.Evolution(number: "", name: "")], image: "")
        
        
        if result == .failure {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        } else {
            return Just(GetAllPokemonsQuery.Data(pokemons: [pokemon]) as! T.Data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
}
