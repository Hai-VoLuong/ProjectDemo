//
//  Generic+CollectionViewController.swift
//  projectDemo
//
//  Created by MAC on 12/13/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class BaseCollectionCell<U>: UICollectionViewCell {
    
    var item: U!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class BaseCollecitonView<T: BaseCollectionCell<U>, U>: UICollectionViewController {
    
    let cellId = "id"
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(T.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
}
