//
//  DrapAndDropVideo.swift
//  projectDemo
//
//  Created by MAC on 12/17/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class DrapAndDropVideo: UIViewController {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "tinder"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // keep track of constraints so we can modify them later
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drap And Drop Video"
        view.backgroundColor = .white
        setupViews()
        setupAnimator()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
}

extension DrapAndDropVideo {
    
    @objc private func handleTap() {
        animator.startAnimation()
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translationY = gesture.translation(in: view).y
            let totalHeight = view.frame.height - 200
            let percentage = translationY / totalHeight
            animator.fractionComplete = percentage
        case .ended:
            animator.stopAnimation(true)
        default:
            Void()
        }
    }
        
    private func setupViews() {
        view.addSubview(imageView)
        topConstraint = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        leadingConstraint = imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        trailingConstraint = imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9/16)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])

        bottomConstraint = imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    // setup animation when tap on view
    private func setupAnimator() {
        animator.addAnimations { [weak self] in
            guard let this = self else { return }
            this.topConstraint.isActive = false
            this.leadingConstraint.isActive = false
            this.trailingConstraint.constant = -8
            this.bottomConstraint.isActive = true
            this.bottomConstraint.constant = -8
            this.imageView.widthAnchor.constraint(equalToConstant: this.view.frame.width / 2).isActive = true
            this.view.layoutIfNeeded()
        }
        animator.stopAnimation(true)
    }
}


