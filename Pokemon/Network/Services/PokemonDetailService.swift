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
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .convertSnakeCase){
        self.session = session
        self.decoder = decoder
    }
    
    func fetchPokemonDetail(id: Int) -> AnyPublisher<PokemonDetailResponse, Error> {
        guard let url = URL(string: Constants.Network.pokeApiURL + "\(id)/") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { _ in return NetworkError.failLoadData }
            .decode(type: PokemonDetailResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
