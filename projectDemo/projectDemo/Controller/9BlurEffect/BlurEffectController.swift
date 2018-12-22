//
//  BlurEffectController.swift
//  projectDemo
//
//  Created by MAC on 12/22/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class BlurEffectController: UIViewController {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "lady5c")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
     private let slider: UISlider = {
        let s = UISlider()
        
        s.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return s
    }()
    
    private let animator: UIViewPropertyAnimator = {
        let a = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
        return a
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let v = UIVisualEffectView()
        return v
    }()
    
    //MARK: -  Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIViewPropertyAnimator Blur Effect"
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupViews()
        setupAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        animator.startAnimation()
    }
    
    @objc private func handleSliderChange(slider: UISlider) {
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    @objc private func handleTap() {
        UIView.animate(withDuration: 1.0) {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    private func setupAnimation() {
        animator.addAnimations { [weak self] in
            guard let this = self else { return }
            this.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            this.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
    }
}

extension BlurEffectController {
    
    private func setupViews() {
        view.addSubview(imageView)
        imageView.anchorCenterInSuperview(size: CGSize(width: 200, height: 200))
        
        view.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        view.addSubview(slider)
        slider.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, bottom: nil, trailing: imageView.trailingAnchor)
    }
}
