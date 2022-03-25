//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var pokemonDescription = ""
    @Published var activeSprite = 0
    @Published var errorMessage: String?
//    @Published var evolutionsPokemon: [Pokemon]
    
    private var cancellables = Set<AnyCancellable>()
    private let service: PokemonDetailService
    
    init(pokemon: Pokemon, service: PokemonDetailService = PokemonDetailService()) {
        self.pokemon = pokemon
        self.service = service
        getDetail(pokemon)
    }
    
    func getSprite(pokemon: Pokemon) -> URL? {
        if activeSprite == 0 {
            return pokemon.spriteFrontDefaultImage
        }
        return pokemon.spriteFrontShinyImage
    }
    
    
    func getDetail(_ pokemon: Pokemon) {
        service.fetchPokemonDetail(id: pokemon.idInt)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                    case .finished:
                        self?.errorMessage = nil
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                
            }, receiveValue: { [weak self] in
                self?.addFlavorText($0)
            })
            .store(in: &cancellables)
    }
    
    func addFlavorText(_ response: PokemonDetailResponse) {
        let responseText = response.flavorTextEntries.first { $0.language.name == "en" && $0.flavorText.contains(pokemon.namePokemon)}?.flavorText ?? ""

        self.pokemonDescription = responseText.components(separatedBy: .newlines).joined()
    }
}
