//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Mariana Steblii on 23/03/2021.
//

import UIKit

class PokemonViewController: UIViewController {
    var stateController: StateController?
    var selectedPokemonIndex: Int!
    
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedPokemon = stateController?.pokemons?[selectedPokemonIndex]
        let link = stateController?.createLink(pokemonLink: selectedPokemon!)
        let cacheImage = stateController?.imageCache.object(forKey: link! as NSString)
        
        if let selectedPokemon = selectedPokemon {
            pokemonName.text = selectedPokemon.name.capitalized
            pokemonImage.image = cacheImage
        }
    }
   
//    @IBAction func BackButtonPressed(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
}
