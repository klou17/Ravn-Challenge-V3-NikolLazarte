//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import Combine
import SwiftUI

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var pokemonDescription = ""
    @Published var pokemonColor = ""
    @Published var activeSprite = 0
    @Published var pokemonDefault = ""
    @Published var pokemonShiny = ""
    @Published var evolutions: [Pokemon]?
    @Published var error: NetworkError?
    
    private var cancellables = Set<AnyCancellable>()
    private let service: PokemonDetailService
    
    init(pokemon: Pokemon, service: PokemonDetailService = PokemonDetailService(), evolutions: [Pokemon]?) {
        self.pokemon = pokemon
        self.service = service
        self.evolutions = evolutions
        fetchDetail(pokemon)
    }
    
    var urlSprite: URL? {
        if activeSprite == 0 {
           return URL(string: pokemonDefault)
       }
       return URL(string: pokemonShiny)
    }
    
    func getEvolutions(pokemon: Pokemon) -> [Pokemon]? {
        return evolutions?.filter { $0.namePokemon != pokemon.namePokemon}
    }
    
    func getSprite(pokemon: Pokemon) -> URL? {
        return pokemon.spriteFrontDefaultImage
    }
    
    func fetchDetail(_ pokemon: Pokemon) {
        service.fetchSpeciesDetail(id: pokemon.idInt)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                    case .finished:
                        self?.error = nil
                    case .failure:
                        self?.error = .failLoadData
                    }
                
            }, receiveValue: { [weak self] in
                self?.receiveSpecies(for: $0)
            })
            .store(in: &cancellables)
        
        service.fetchSpritesDetail(id: pokemon.idInt)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                    case .finished:
                        self?.error = nil
                    case .failure:
                        self?.error = .failLoadData
                    }
                
            }, receiveValue: { [weak self] in
                self?.receiveSprites(for: $0)
            })
            .store(in: &cancellables)
    }
    
    func receiveSprites(for response: PokemonSpritesResponse) {
        self.pokemonDefault = response.sprites.frontDefault
        self.pokemonShiny = response.sprites.frontShiny
    }
    
    func receiveSpecies(for response: PokemonSpeciesResponse) {
        let responseText = response.flavorTextEntries.first { $0.language.name == "en" && $0.flavorText.contains(pokemon.namePokemon)}?.flavorText ?? ""

        self.pokemonColor = response.color.name
        self.pokemonDescription = responseText.components(separatedBy: .newlines).joined()
    }
}
