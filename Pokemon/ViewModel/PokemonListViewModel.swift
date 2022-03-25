//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import Foundation
import Combine
import Apollo

//struct PokemonGeneration {
//    let name: String
//    var pokemons: [Pokemon]
//}


class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var searchText = ""
    @Published var errorLoadData = false
    @Published var errorMessage: String?
//    @Published var generations = [PokemonGeneration(name: "", pokemons: [])]
//    @Published var generations = [String: [Pokemon]]()
    
    
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            print("pokemons: \(pokemons)")
            return pokemons
        } else {
            return pokemons.filter { return $0.namePokemon.starts(with: searchText)}
        }
    }
    
    var pokemonsGroupSection: [String: [Pokemon]] {
        return Dictionary(grouping: pokemons, by: { $0.generationPokemon })
    }
    
//    var generations: [String] {
//        return pokemonsGroupSection.keys.sorted(by: <)
//    }
    
    var pokemonsSectioned: [String: [Pokemon]] {
        Dictionary(grouping: searchResults) {
            $0.generationPokemon
        }
    }

    var generations: [String] {
        return pokemonsSectioned.keys.sorted(by: <).map { String($0) }
    }

    var evolutionsPokemon: [Pokemon] {
        let group = pokemons.filter { $0.evolutionPokemon.contains( $0.idInt ) }
        return group
    }
    
    private var service: PokemonListService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: PokemonListService = PokemonListService()){
        self.service = service
    }
    
    func subscriptions() {
        errorLoadData = true
        service.fetchPokemons()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                
            }, receiveValue: { [weak self] in
                self?.pokemons.append(contentsOf: $0)
                print("pokemons \(self?.pokemons)")
                self?.errorLoadData = false
            })
            .store(in: &cancellables)
    }
}
