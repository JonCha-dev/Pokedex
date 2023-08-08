//
//  PokedexModel.swift
//  Pokedex
//
//  Created by Jon Chang on 8/7/23.
//

import Foundation

struct PokedexModel: Decodable {
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Hashable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.name == rhs.name
    }
    
    internal func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var name: String
    var data: PokemonData
}

struct PokemonData: Decodable {
    let id: Int
    let height: Int
    let weight: Int
}

struct mockData {
    static let mockPkmn = Pokemon(name: "bulbasaur", data: PokemonData(id: 1, height: 7, weight: 69))
    static let mockPkmn2 = Pokemon(name: "ivysaur", data: PokemonData(id:2, height:10, weight: 80))
}
