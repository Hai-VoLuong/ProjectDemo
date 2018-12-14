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
    let loadView = UIActivityIndicatorView(style: .whiteLarge)
    var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing Json With Decoder"
        view.backgroundColor = .yellow
        tableView.backgroundColor = .white

        fetchData()
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

    private func fetchData() {
        putInLoadingState()
        fetchCoursesFromWebSite(url: jsonString) { [weak self] (homeFeed) in
            guard let this = self else { return }
            this.loadView.stopAnimating()
            this.homeFeed = homeFeed
            this.reloadData()
        }
    }

    private func putInLoadingState() {
        homeFeed = nil
        isLoadingData = true
        view.addSubview(loadView)
        loadView.fillSuperview()
        loadView.color = .red
        loadView.startAnimating()
    }

    private func reloadData() {
        isLoadingData = false
        loadView.stopAnimating()
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



