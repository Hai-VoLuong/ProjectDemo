//
//  BarChartController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class BarChartCell: BaseCollectionCell<CGFloat> {

    private let barView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()

    private var barHeightConstraint: NSLayoutConstraint? = nil

    override var item: CGFloat! {
        didSet {
            barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: frame.height * item)
            barHeightConstraint?.isActive = true

        }
    }

    override var isHighlighted: Bool {
        didSet {
            barView.backgroundColor = isHighlighted ? .black : .red
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(barView)
        barView.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
    }
}

final class BarChartController: BaseCollecitonView<BarChartCell, CGFloat>, UICollectionViewDelegateFlowLayout {


    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bar Chart"
        let values:[CGFloat] = [200, 300, 500, 100, 600, 10, 50, 250, 550, 1000, 600, 3000]

        // calulator height item
        if let max = values.max() {
            values.forEach { (item) in
                let radio = item / max
                items.append(radio)
            }
        }
        setupViews()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: view.frame.height - 20 - 44 - 8)
    }
}

extension BarChartController {

    private func setupViews() {
        setupCollectionViewLayout()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
    }

    private func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 4
            layout.sectionInset = .init(top: 0, left: 4, bottom: 0, right: 4)
        }
    }
}

