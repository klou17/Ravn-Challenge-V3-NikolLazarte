//
//  Network.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import Apollo
import Combine

final class Network {
    static let shared = Network()
    private(set) lazy var client = ApolloClient(url: URL(string: Constants.Network.graphqlURL)!)
    
    func fetch<T: GraphQLQuery>(_ query: T) -> AnyPublisher<T.Data, Error> {
        Future { [client] promise in
            client.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    if let data = graphQLResult.data {
                        promise(.success(data))
                    } else if let errors = graphQLResult.errors {
                        let message = errors.map(\.localizedDescription).joined(separator: "\n")
//                        promise(.failure(NetworkError(message: message)))
                        promise(.failure(NetError.failedToLoadData(error: message)))
                    }

                case .failure(let error):
//                    promise(.failure(NetworkError(message: error.localizedDescription)))
                    promise(.failure(NetError.conexionFail(error: error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

