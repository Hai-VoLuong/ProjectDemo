//
//  AnimationLikeFacebook.swift
//  projectDemo
//
//  Created by MAC on 12/22/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class AnimationLikeFacebookController: UIViewController {

    private let textLabel: UILabel = {
        let l = UILabel()
        l.text = "long tap view"
        l.textColor = .lightGray
        l.textAlignment = .center
        return l
    }()

    private let containerView: UIView = {
        // 1
        let v = UIView()
        v.backgroundColor = .white
        
        // configuration options
        let iconHeight: CGFloat = 38
        let padding: CGFloat = 6
        
        let images = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")]
        
        let arrangedSubviews = images.map({ (image) -> UIView in
            let iv = UIImageView(image: image)
            iv.layer.cornerRadius = iconHeight / 2
            // required for hit testing
            iv.isUserInteractionEnabled = true
            return iv
        })

        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        v.addSubview(stackView)
        
        let numIcons = CGFloat(arrangedSubviews.count)
        let width =  numIcons * iconHeight + (numIcons + 1) * padding
        
        v.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        v.layer.cornerRadius = v.frame.height / 2
        
        // shadow
        v.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        v.layer.shadowRadius = 8
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = v.frame
        
        return v
    }()
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation Like Facebook"
        view.backgroundColor = .white
        view.addSubview(textLabel)
        textLabel.fillSuperview()
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            handleGestureBegan(gesture: gesture)
        case .changed:
            handleGestureChanged(gesture: gesture)
        case .ended:
            handleGestureEnded()
        default:
            Void()
        }
    }
}

extension AnimationLikeFacebookController {

    // began
    private func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let this = self else { return }
            this.textLabel.alpha = 0
        })

        view.addSubview(containerView)
        
        let pressedLocation = gesture.location(in: self.view)
        let centeredX = (view.frame.width - containerView.frame.width) / 2
        containerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let this = self else { return }
            this.containerView.alpha = 1
            this.containerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - this.containerView.frame.height)
        })
    }

    // change
    private func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: containerView)

        let fixedYLocation = CGPoint(x: pressedLocation.x, y: containerView.frame.height / 2)

        let hitTestView = containerView.hitTest(fixedYLocation, with: nil)

        if hitTestView is UIImageView {

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                guard let this = self else { return }
                let stackView = this.containerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }

    // end
    private func handleGestureEnded() {
        // clean up the animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let this = self else { return }
            let stackView = this.containerView.subviews.first
            stackView?.subviews.forEach({ (imageView) in
                imageView.transform = .identity
            })

            this.containerView.transform = this.containerView.transform.translatedBy(x: 0, y: 50)
            this.containerView.alpha = 0

            }, completion: { [weak self] (_) in
                guard let this = self else { return }
                this.containerView.removeFromSuperview()
                this.textLabel.alpha = 1
        })
    }
}
