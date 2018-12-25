//
//  ShimmerController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/18/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class ShimmerController: UIViewController {

    let darkTextLabel: UILabel = {
        let l = UILabel()
        l.text = "Shimmer"
        l.textColor = UIColor(white: 1, alpha: 0.2)
        l.font = UIFont.systemFont(ofSize: 80)
        l.textAlignment = .center
        return l
    }()

    let shinyTextLabel: UILabel = {
        let l = UILabel()
        l.text = "Shimmer"
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 80)
        l.textAlignment = .center
        return l
    }()

    let gradientLayer = { () -> CAGradientLayer in
        let g = CAGradientLayer()
        g.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear]
        g.locations = [0, 0.5, 1]
        return g
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shimmer"
        view.backgroundColor = .blue

        view.addSubview(darkTextLabel)
        darkTextLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 400))

        view.addSubview(shinyTextLabel)
        shinyTextLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 400))

        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)

        // toạ độ góc layer
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        shinyTextLabel.layer.mask = gradientLayer

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: "a")

    }
}
