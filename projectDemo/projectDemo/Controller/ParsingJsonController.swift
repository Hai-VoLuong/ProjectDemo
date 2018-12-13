//
//  SwipingController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
}

final class ParsingJsonController: UIViewController {
    
    let jsonString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing Json With Decodable"
        view.backgroundColor = .red
        
        guard let url = URL(string: jsonString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print("\(courses)\n")
            } catch let err {
                print("error serializing json, \(err.localizedDescription)")
            }
        }.resume()
    }
}

