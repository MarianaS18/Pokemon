//
//  StateController.swift
//  Pokemon
//
//  Created by Mariana Steblii on 22/03/2021.
//

import UIKit

class StateController {
    var onComplete: (()->())?
    let networkController = NetworkController()
    let imageCache = NSCache<NSString, UIImage>()
    var pokemons: [Pokemon]?
    
    init() {
        networkController.delegate = self
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1118")!
        let decoder = JSONDecoder()
        
        networkController.fetchData(of: PokemonData.self, from: url, decoder: decoder) { [weak self](result) in
            switch result {
            case .failure(let error):
                if error is DataError {
                    print(error)
                } else {
                    print(error.localizedDescription)
                }
            case .success(let result):
                self?.didComplete(pokemons: result.pokemons)
            }
        }
    }
    
    
    func createLink(pokemonLink: Pokemon) -> String {
        let str = pokemonLink.url
        let newLink =  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(str.split(separator: "/").last ?? "").png"
        return newLink
    }
}


extension StateController: NetworkControllerDelegate {
    func didComplete(pokemons: [Pokemon]) {
        self.pokemons = pokemons
        if let onComplete = onComplete {
            onComplete()
        }
    }
}


