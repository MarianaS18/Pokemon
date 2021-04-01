//
//  ViewController.swift
//  Pokemon
//
//  Created by Mariana Steblii on 22/03/2021.
//

import UIKit

class PokemonListViewController: UIViewController {
    var stateController: StateController?
    
    @IBOutlet weak var pokemonListTableView: UITableView! {
        didSet {
            pokemonListTableView.dataSource = self
            pokemonListTableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        stateController?.onComplete = { [weak self] in
            self?.pokemonListTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemon" {
            let destinationVC = segue.destination as? PokemonViewController
            destinationVC?.stateController = stateController
            destinationVC?.selectedPokemonIndex = pokemonListTableView.indexPathForSelectedRow?.row
        }
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateController?.pokemons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonListTableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        guard  let pokemon = stateController?.pokemons?[indexPath.row] else {
            return cell
        }
        
        cell.pokemonLabel.text = (pokemon.name).capitalized
        if let link = stateController?.createLink(pokemonLink: pokemon) {
            if let image = stateController?.imageCache.object(forKey: link as NSString) {
                cell.imageView?.image = image
            } else {
                if let imgUrl = URL(string: link) {
                    cell.imageView?.load(url: imgUrl, completion: { [weak self] image in
                        cell.setNeedsLayout()
                        self?.stateController?.imageCache.setObject(image, forKey: link as NSString)
                    })
                }
            }
        }
        
      
        cell.selectionColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
