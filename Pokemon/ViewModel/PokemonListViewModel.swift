//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var searchText = ""
    @Published var errorLoadData = false
    
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            print("pokemons: \(pokemons)")
            return pokemons
        } else {
            return pokemons.filter { return $0.namePokemon.starts(with: searchText)}
        }
    }
    
    private var service: PokemonListService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: PokemonListService = PokemonListService()){
        self.service = service
        subscriptions()
    }
    
    func subscriptions() {
        service.fetchPokemons()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] in
//                self?.pokemons.append(contentsOf: $0)
                self?.pokemons = $0
            })
            .store(in: &cancellables)
    }
}
