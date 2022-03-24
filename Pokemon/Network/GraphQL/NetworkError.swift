//
//  NetworkError.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 22/03/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failLoadData
    case failConexion

    var messageErrorTitle: String {
        switch self {
        case .invalidURL, .failLoadData:
            return Constants.ErrorText.wasError
        case .failConexion:
            return Constants.ErrorText.connectivityIssue
        }
    }
    
    var messageErrorBody: String {
        switch self {
        case .invalidURL, .failLoadData:
            return Constants.ErrorText.failLoadData
        case .failConexion:
            return Constants.ErrorText.problemToConnect
        }
    }
}
