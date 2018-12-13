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

final class ParsingJsonCell: GenericTableCell<Course> {
    
    override var item: Course! {
        didSet {
            textLabel?.text = item.name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .blue
        textLabel?.textColor = .white
    }
}

final class ParsingJsonController: GenericTableViewController<ParsingJsonCell, Course> {
    
    let jsonString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing Json With Decodable"
        view.backgroundColor = .red
        
        guard let url = URL(string: jsonString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                DispatchQueue.main.async { 
                    self.items = websiteDescription.courses
                    self.tableView.reloadData()
                }
                
            } catch let err {
                print("error serializing json, \(err.localizedDescription)")
            }
        }.resume()
    }
}

