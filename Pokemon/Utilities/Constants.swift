//
//  Constants.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import UIKit

struct Constants {
    enum Network {
        static let graphqlURL = "https://graphql-pokemon2.vercel.app"
        static let restSpeciesURL = "https://pokeapi.co/api/v2/pokemon-species/"
        static let restSpritesURL = "https://pokeapi.co/api/v2/pokemon/"
    }
    
    enum ErrorText {
        static let wasError = "There was an Error"
        static let connectivityIssue = "Connectivity Issue"
        static let failLoadData = "Failed to Load Data"
        static let problemToConnect = "There is a problem trying to connect.\nPlease check your connectivity."
        static let noResults = "No Results Found"
        static let noAnyPokemon = "We can't any pokemon matching your search"
    }
}
