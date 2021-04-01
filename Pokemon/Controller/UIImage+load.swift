//
//  UIImage+load.swift
//  Pokemon
//
//  Created by Mariana Steblii on 22/03/2021.
//

// https://pokeapi.co/api/v2/pokemon/1/
// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png


import UIKit

extension UIImageView {
    func load(url: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                    }
                }
            }
        }
    }
    

}
