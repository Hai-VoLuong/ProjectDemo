//
//  Generic+ServerAPI.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

struct Service {
    static let shared = Service()

    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed:", err)
                return
            }

            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(obj)
                }
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
            }
        }.resume()
    }
}
