//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import SwiftUI

@main
struct PokemonApp: App {
//    @StateObject var monitor = InternetConexion()
    var body: some Scene {
        WindowGroup {
            PokemonListView(viewModel: .init())
                
                
//            PokemonDetailView(viewModel: .init(pokemon: Pokemon(id: 3, name: "BAA", color: "green", generation: "la 1", sprites: .init(frontDefault: "", frontShiny: ""),  evolvesTo: [])))
        }
    }
}
