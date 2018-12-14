//
//  SwipingController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class HomeFeedCell: GenericTableCell<Video> {

    override var item: Video! {
        didSet {
            textLabel?.text = item.name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
    }
}

final class HomeFeedController: GenericTableView<HomeFeedCell, Video> {
    
    let jsonString = "https://api.letsbuildthatapp.com/youtube/home_feed"
    var homeFeed: HomeFeed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing Json With Decoder"
        view.backgroundColor = .yellow
        tableView.backgroundColor = .white

        fetchCoursesFromWebSite(url: jsonString) { (homeFeed) in
            self.homeFeed = homeFeed
            self.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let detailHomeFeedVC = DetailHomeFeedController(collectionViewLayout: layout)
        detailHomeFeedVC.video = homeFeed?.videos[indexPath.row]
        navigationController?.pushViewController(detailHomeFeedVC, animated: true)
    }
}

extension HomeFeedController {

    // reload data
    private func reloadData() {
        items = homeFeed?.videos ?? []
        tableView.reloadData()
    }

    // fetch courses from website
    private func fetchCoursesFromWebSite(url: String, completion: @escaping (HomeFeed) -> ()) {
        Service.shared.fetchGenericData(urlString: url) { (homeFeed: HomeFeed) in
            completion(homeFeed)
        }
    }
}



