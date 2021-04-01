//
//  NetworkController.swift
//  Pokemon
//
//  Created by Mariana Steblii on 22/03/2021.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

protocol  NetworkControllerDelegate: class {
    func didComplete(pokemons: [Pokemon])
}

class NetworkController {
    weak var delegate: NetworkControllerDelegate?
    typealias  result<T> = (Result<T, Error>) -> Void
    
    func fetchData<T: Decodable>(of type: T.Type, from url: URL, decoder: JSONDecoder, completion: @escaping result<T>){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }

            if 200...299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: T = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                    }
                    catch {
                        DispatchQueue.main.async {
                            completion(.failure(DataError.decodingError))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(DataError.invalidData))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(DataError.serverError))
                }
            }
        }.resume()
    }
}

