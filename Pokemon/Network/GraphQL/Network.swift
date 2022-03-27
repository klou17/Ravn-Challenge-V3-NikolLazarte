//
//  Network.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import Apollo
import Combine

protocol NetworkServiceType {
    func fetch<T: GraphQLQuery>(_ query: T) -> AnyPublisher<T.Data, Error>
}

class Network: NetworkServiceType {
    static let shared = Network()
    private(set) lazy var client = ApolloClient(url: URL(string: Constants.Network.graphqlURL)!)
    
    func fetch<T: GraphQLQuery>(_ query: T) -> AnyPublisher<T.Data, Error> {
        Future { [client] promise in
            client.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let data = graphQLResult.data else {
                        promise(.failure(NetworkError.failLoadData))
                        return
                    }
                    promise(.success(data))

                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

