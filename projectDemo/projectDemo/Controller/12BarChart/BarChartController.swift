//
//  BarChartController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class BarChartCell: BaseCollectionCell<UIColor> {

    override var item: UIColor! {
        didSet {
            backgroundColor = item
        }
    }
}

final class BarChartController: BaseCollecitonView<BarChartCell, UIColor>, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bar Chart"
        items = [.blue, .blue]
        collectionView.backgroundColor = .white
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: view.frame.height)
    }
}

