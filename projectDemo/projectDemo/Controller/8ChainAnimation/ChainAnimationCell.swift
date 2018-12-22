//
//  ChainAnimationCell.swift
//  projectDemo
//
//  Created by MAC on 12/21/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

protocol ChainAnimationCellProtocol {
    func scrollToItem()
}

final class ChainAnimationCell: BaseCollectionCell<Page> {
    
    var delegate: ChainAnimationCellProtocol?
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Quick Lists"
        l.font = UIFont(name: "Futura", size: 44)
        l.numberOfLines = -1
        return l
    }()
    
    private let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "How to create a custom list under one minute"
        l.font = UIFont(name: "HelveticaNeue", size: 22)
        l.numberOfLines = -1
        return l
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.addArrangedSubview(titleLabel)
        sv.addArrangedSubview(bodyLabel)
        sv.axis = .vertical
        sv.spacing = 0
        return sv
    }()
    
    override var item: Page! {
        didSet {
            titleLabel.text = item.headerText
            bodyLabel.text = item.bodyText
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTitleTap)))
        
        bodyLabel.isUserInteractionEnabled = true
        bodyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBodyTap)))
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleBodyTap() {
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        bodyLabel.backgroundColor = .black
        bodyLabel.textColor = .white
    }
    
    @objc private func handleTitleTap() {
        titleLabel.backgroundColor = .black
        titleLabel.textColor = .white
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .black
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        
        // đảm bảo tap vào bên trái(đi tiếp) thì hoạt động còn lại thì không
        if location.x < frame.width / 2 {
            reset()
        } else {
            // animation title
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { [weak self] in
                guard let this = self else { return }
                this.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.titleLabel.alpha = 0
                    self.titleLabel.transform = CGAffineTransform(translationX: -30, y: -200)
                })
            }
            
            // animation body
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.75, options: .curveEaseOut, animations: { [weak self] in
                guard let this = self else { return }
                this.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                self.perform(#selector(self.nextItem), with: nil, afterDelay: 0.3)
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.bodyLabel.alpha = 0
                    self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: -200)
                })
            }
        }
    }
    
    override func prepareForReuse() {
        reset()
    }
    
    @objc func nextItem() {
        delegate?.scrollToItem()
    }
    
    private func reset() {
        titleLabel.transform = .identity
        titleLabel.alpha = 1
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        
        bodyLabel.transform = .identity
        bodyLabel.alpha = 1
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .black
    }
}

extension ChainAnimationCell {
    
    private func setupViews() {
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -100).isActive = true
    }
}

