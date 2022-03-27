//
//  Decoder.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 25/03/22.
//

import Foundation

extension JSONDecoder {
    static var convertSnakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
