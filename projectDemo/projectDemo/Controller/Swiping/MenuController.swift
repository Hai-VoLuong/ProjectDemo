//
//  MenuController.swift
//  projectDemo
//
//  Created by MAC on 12/15/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class MenuCell: BaseCollectionCell<String> {

    let textLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .lightGray
        return l
    }()
    
    override var item: String! {
        didSet {
            textLabel.text = item
        }
    }
    
    override var isSelected: Bool {
        didSet {
            textLabel.textColor = isSelected ? .black : .lightGray
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(textLabel)
        textLabel.fillSuperview()
    }
}

protocol MenuControllerDelegate {
    func didTapMenuItem(indexPath: IndexPath)
}

final class MenuController: BaseCollecitonView<MenuCell, String>, UICollectionViewDelegateFlowLayout {
    
    let menuBarViewBlack: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()

    var delegate: MenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        items = ["Home", "Feed", "Trend"]
       
        setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / CGFloat(items.count), height: view.frame.height)
    }

    // use delegate effect when tap item then all collection view follow into
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
}

extension MenuController {

    private func setupViews() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }

        collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .centeredHorizontally)
        view.addSubview(menuBarViewBlack)

        menuBarViewBlack.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, size: .init(width: 0, height: 5))
        menuBarViewBlack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / CGFloat(items.count)).isActive = true
    }
}
