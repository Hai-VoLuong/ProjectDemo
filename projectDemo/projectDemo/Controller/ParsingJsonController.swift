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

final class ParsingJsonCell: GenericCollectionCell<Course> {
    
    let textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override var item: Course! {
        didSet {
            textLabel.text = item.name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        addSubview(textLabel)
        textLabel.fillSuperview()
    }
}

final class ParsingJsonController: GenericCollecitonView<ParsingJsonCell, Course> {
    
    let jsonString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
    var courses: [Course]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing Json With Decoder"
        view.backgroundColor = .yellow
        collectionView.backgroundColor = .white

        fetchCoursesFromWebSite(url: jsonString) { (website) in
            self.courses = website.courses
            self.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}

extension ParsingJsonController {

    // reload data
    private func reloadData() {
        items = courses ?? []
        collectionView.reloadData()
    }

    // fetch courses from website
    private func fetchCoursesFromWebSite(url: String, completion: @escaping (WebsiteDescription) -> ()) {
        Service.shared.fetchGenericData(urlString: url) { (websiteDescription: WebsiteDescription) in
            completion(websiteDescription)
        }
    }
}



