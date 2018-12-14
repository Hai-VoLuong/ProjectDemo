//
//  DetailHomeFeedController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class DetailHomeFeedCell: GenericCollectionCell<Course> {

    let textLabel: UILabel = {
        let l = UILabel()
        return l
    }()

    override var item: Course! {
        didSet {
            textLabel.text = item.name
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .yellow
        addSubview(textLabel)
        textLabel.fillSuperview()
    }
}

final class DetailHomeFeedController: GenericCollecitonView<DetailHomeFeedCell, Course>, UICollectionViewDelegateFlowLayout {

    var courses: [Course]?

    var video: Video! {
        didSet {
            let jsonString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=\(video.id)"
            fetchVideos(url: jsonString) { (courses) in
                self.courses = courses
                self.reloadData()
            }
            navigationItem.title = video.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        collectionView.backgroundColor = .white
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension DetailHomeFeedController {

    // reload data
    private func reloadData() {
        items = courses ?? []
        collectionView.reloadData()
    }

    // fetch videos from website
    private func fetchVideos(url: String, completion: @escaping ([Course]) -> ()) {
        Service.shared.fetchGenericData(urlString: url) { (courses: [Course]) in
            completion(courses)
        }
    }
}

