//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import Foundation
import Combine
import Apollo

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var searchText = ""
    @Published var errorLoadData = false
    @Published var error: NetworkError?

    var searchPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { $0.namePokemon.starts(with: searchText)}
        }
    }
    
    var pokemonsGroupSection: [String: [Pokemon]] {
        return Dictionary(grouping: searchPokemons, by: { $0.classificationPokemon })
    }
    
    var classifications: [String] {
        return pokemonsGroupSection.keys.sorted(by: <)
    }
    
    private var service: PokemonListServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(service: PokemonListServiceType = PokemonListService()){
        self.service = service
    }
    
    func fetchPokemons() {
        errorLoadData = true
        service.fetchPokemons()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure:
                    self?.error = .failLoadData
                }
                
            }, receiveValue: { [weak self] in
                self?.pokemons.append(contentsOf: $0)
                self?.errorLoadData = false
            })
            .store(in: &cancellables)
    }
    
    func getEvolutions(to pokemon: Pokemon) -> [Pokemon]? {
        guard let evolutions = pokemon.evolutions else { return nil }
        let evolutionNames = evolutions.map { $0?.name }
        let filter = pokemons.filter { evolutionNames.contains( $0.name) }
        return filter
    }
}
