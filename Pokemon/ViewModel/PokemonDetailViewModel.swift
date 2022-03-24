//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import Combine

//protocol PokemonDetailType {
//    var string: String { get}
//    var flavour: String { get set }
//}
//
//extension Pokemon: PokemonDetailType {
//    var string: String {
//        return ""
//    }
//
////    private var string: String { return "" }
//    var flavour: String {
//        get {
//            return string
//        }
//        set {
//            self = newValue
//        }
//    }
//}

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var activeSprite = 0
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let service: PokemonDetailService
    
    init(pokemon: Pokemon, service: PokemonDetailService = PokemonDetailService()) {
        self.pokemon = pokemon
        self.service = service
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
                
            }, receiveValue: { _ in
//                [weak self] response in
//                self?.pokemon.flavour = response.flavours.first.debugDescription
            })
            .store(in: &cancellables)
    }
}
