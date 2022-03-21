//
//  Network.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    private init() {}

    lazy var client = ApolloClient(url: URL(string: Constants.Network.url)!)
}
