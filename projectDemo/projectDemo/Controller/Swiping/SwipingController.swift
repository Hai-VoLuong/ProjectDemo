//
//  SwipingController.swift
//  projectDemo
//
//  Created by MAC on 12/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SwipingCell: BaseCollectionCell<UIColor> {

    let newItemController = NewItemController()

    override var item: UIColor! {
        didSet {
            backgroundColor = item
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let newItem = newItemController.view!
        addSubview(newItem)
        newItem.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 0))
    }
}

final class SwipingController: BaseCollecitonView<SwipingCell, UIColor>, UICollectionViewDelegateFlowLayout {
    
    var menuView: UIView = {
        let v = UIView()
        return v
    }()
    
     let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Swiping"
        items = [.red, .blue, .green]
        
        setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // effect view black run follow when dragging collection view
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / CGFloat(items.count)
        menuController.menuBarViewBlack.transform = CGAffineTransform(translationX: x, y: 0)
    }
    
    // effect change text color when dragging collection view
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        // amount item has in collection view
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension SwipingController {

    private func setupViews() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
        
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.isPagingEnabled = true

        // delegate when tap item in menuController then item item collection move into follow
        menuController.delegate = self
        menuView = menuController.view!
        
        view.addSubview(menuView)
        menuView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 44))
        
        collectionView.anchor(top: menuView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}

extension SwipingController: MenuControllerDelegate {

    // delegate when tap item in menuController then item collection move into follow
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
