//
//  PokemonDetailService.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation
import Combine

protocol PokemonDetailServiceType {
    func fetchPokemonDetail(id: Int) -> AnyPublisher<PokemonDetailResponse, Error>
    
}


struct PokemonDetailService: PokemonDetailServiceType {
    
    private let session: URLSession
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func fetchPokemonDetail(id: Int) -> AnyPublisher<PokemonDetailResponse, Error> {
        guard let url = URL(string: Constants.Network.pokeApiURL + "\(id)/") else {
            return Fail(error: NetError.invalidURL)
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { error -> Error in
                return NetError.failedToLoadData(error: error.localizedDescription)
            }
            .decode(type: PokemonDetailResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
