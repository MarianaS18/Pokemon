//
//  PokemonData.swift
//  Pokemon
//
//  Created by Mariana Steblii on 22/03/2021.
//

import Foundation

struct PokemonData: Decodable {
    let pokemons: [Pokemon]
    
    private enum CodingKeys: String, CodingKey {
        case pokemons = "results"
    }
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

