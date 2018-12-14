//
//  SwipingController.swift
//  projectDemo
//
//  Created by MAC on 12/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SwipingCell: GenericCollectionCell<String> {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .blue
    }
}

final class SwipingController: GenericCollecitonView<SwipingCell, String> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        title = "Swiping"
    }
}
