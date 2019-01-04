//
//  StretchyHeaderController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class StretchyCell: BaseCollectionCell<UIColor> {

    override var item: UIColor! {
        didSet {
            backgroundColor = item
        }
    }
}

final class StretchyController: BaseCollecitonView<StretchyCell, UIColor>, UICollectionViewDelegateFlowLayout {

    private let headerId = "headerId"
    private let paddingCell: CGFloat = 16
    private var headerView: StretchyHeaderCell!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        headerView.animator.stopAnimation(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stretchy Header"
        items = [.blue, .blue,.blue, .blue,.blue, .blue,.blue, .blue,.blue, .blue,.blue, .blue]
        setupViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            headerView.animator.fractionComplete = 0
            return
        }
        
        headerView.animator.fractionComplete = abs(contentOffsetY) / 100
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? StretchyHeaderCell
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * paddingCell, height: 50)
    }
}

extension StretchyController {

    private func setupViews() {
        setupCollectionViewLayout()
        setupCollectionView()
    }

    private func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: paddingCell, left: paddingCell, bottom: paddingCell, right: paddingCell)
        }
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(StretchyHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }

}
