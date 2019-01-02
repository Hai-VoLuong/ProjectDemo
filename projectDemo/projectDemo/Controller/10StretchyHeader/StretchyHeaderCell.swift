//
//  StretchyHeaderCell.swift
//  projectDemo
//
//  Created by MAC on 1/2/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit

final class StretchyHeaderCell: UICollectionReusableView {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "tinder")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
        
    var animator: UIViewPropertyAnimator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(imageView)
        imageView.fillSuperview()
        setupVisulalEffectBlur()
    }
    
    private func setupVisulalEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            guard let this = self else { return }
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            this.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
