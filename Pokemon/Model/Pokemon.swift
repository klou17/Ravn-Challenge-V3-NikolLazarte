//
//  Pokemon.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let frontDefaultSprite: URL?
    let frontShinySprite: URL?
    let generation: String
    let types: [TypePokemon]
//    let color: ColorPokemon?
    
    init(
        id: Int,
        name: String,
        frontDefaultSprite: URL?,
        frontShinySprite: URL?,
        generation: String,
        types: [TypePokemon]
//        color: ColorPokemon
    ) {
        self.id = id
        self.name = name
        self.frontDefaultSprite = frontDefaultSprite
        self.frontShinySprite = frontShinySprite
        self.generation = generation
        self.types = types
//        self.color = color
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case generation
        case types
        case sprites
//        case color
    }
    
    enum CodingKeysSprites: String, CodingKey {
        case frontDefaultSprite = "front_default"
        case frontShinySprite = "front_shiny"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(generation, forKey: .generation)
        try container.encode(types, forKey: .types)
    }
    
}

extension Pokemon {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.generation = try container.decode(String.self, forKey: .generation)
        self.types = try container.decode([TypePokemon].self, forKey: .types)
//        self.color = try container.decode(ColorPokemon.self, forKey: .color)
        
        let containerSprites = try container.nestedContainer(keyedBy: CodingKeysSprites.self, forKey: .sprites)
        self.frontDefaultSprite = try containerSprites.decode(URL.self, forKey: .frontDefaultSprite)
        self.frontShinySprite = try containerSprites.decode(URL.self, forKey: .frontShinySprite)
    }
}
