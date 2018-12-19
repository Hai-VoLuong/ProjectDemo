//
//  SwipePageController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SwipePageCell: BaseCollectionCell<UIColor> {

    override var item: UIColor! {
        didSet {
            backgroundColor = item
        }
    }
}

final class SwipePageController: BaseCollecitonView<SwipePageCell, UIColor>, UICollectionViewDelegateFlowLayout {


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swipe Pages"
        collectionView.backgroundColor = .white
        items = [.red, .blue, .yellow]
        setupViews()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension SwipePageController {

    private func setupViews() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
    }
}
