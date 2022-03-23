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
    
    private var service: PokemonListService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: PokemonListService = PokemonListService()){
        self.service = service
        subscriptions()
    }
    
    private func subscriptions() {
        service.fetchPokemons()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] in
                self?.pokemons = $0
            })
            .store(in: &cancellables)
    }
}
