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
    @Published var errorMessage: String?
    @Published var pokemonDefault = ""
    @Published var pokemonShiny = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let service: PokemonDetailService
    
    init(pokemon: Pokemon, service: PokemonDetailService = PokemonDetailService()) {
        self.pokemon = pokemon
        self.service = service
        fetchDetail(pokemon)
    }
    
    var urlSprite: URL? {
        if activeSprite == 0 {
           return URL(string: pokemonDefault)
       }
       return URL(string: pokemonShiny)
    }
    
    func fetchDetail(_ pokemon: Pokemon) {
        service.fetchSpeciesDetail(id: pokemon.idInt)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                    case .finished:
                        self?.errorMessage = nil
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                
            }, receiveValue: { [weak self] in
                self?.receive(for: $0)
            })
            .store(in: &cancellables)
        
        service.fetchSpritesDetail(id: pokemon.idInt)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                    case .finished:
                        self?.errorMessage = nil
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
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
    
    func receive(for response: PokemonSpeciesResponse) {
        let responseText = response.flavorTextEntries.first { $0.language.name == "en" && $0.flavorText.contains(pokemon.namePokemon)}?.flavorText ?? ""

        self.pokemonColor = response.color.name
        self.pokemonDescription = responseText.components(separatedBy: .newlines).joined()
    }
}
