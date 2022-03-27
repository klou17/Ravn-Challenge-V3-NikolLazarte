//
//  PokemonDetailService.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 23/03/22.
//

import Foundation
import Combine

protocol PokemonDetailServiceType {
    func fetchSpeciesDetail(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error>
    func fetchSpritesDetail(id: Int) -> AnyPublisher<PokemonSpritesResponse, Error>
}


struct PokemonDetailService: PokemonDetailServiceType {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared){
        self.session = session
        self.decoder = JSONDecoder.convertSnakeCase
    }
    
    func fetchSpeciesDetail(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        guard let url = URL(string: Constants.Network.restSpeciesURL + "\(id)/") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { _ in return NetworkError.failLoadData }
            .decode(type: PokemonSpeciesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func fetchSpritesDetail(id: Int) -> AnyPublisher<PokemonSpritesResponse, Error> {
        guard let url = URL(string: Constants.Network.restSpritesURL + "\(id)/") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: url)
            .map { response in response.data }
            .mapError { _ in return NetworkError.failLoadData }
            .decode(type: PokemonSpritesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
