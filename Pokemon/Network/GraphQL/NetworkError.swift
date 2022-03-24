//
//  NetworkError.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 22/03/22.
//

import Foundation

struct NetworkError: Error {
    let message: String
}

enum NetError: Error {
    case invalidURL
    case failedToLoadData(error: String)
    case conexionFail(error: String)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .failedToLoadData(let error):
            return error
        case .conexionFail(let error):
            return error
        }
    }
}
