//
//  Pokemon.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import Foundation

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let frontDefaultSprite: URL?
    let frontShinySprite: URL?
    let generation: String
    let types: [String]
}
