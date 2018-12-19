//
//  SwipePageController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SwipePageController: UIViewController {

    // top view
    private let topContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()

    private let bearImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "bear"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    // midle view
    private let TextView: UITextView = {
        let tv = UITextView()
        let mutableAttributedString = NSMutableAttributedString(string: "More ways to shop", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])

        mutableAttributedString.append(NSAttributedString(string: "\n\nVisit an Apple Store. Call 1-800-MY-APPLE, or find a reseller.\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in out stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
             NSAttributedString.Key.foregroundColor: UIColor.gray]))

        mutableAttributedString.setAsLink(textToFind: "Apple Store", linkName: "AppleStoreLink")
        mutableAttributedString.setAsLink(textToFind: "1-800-MY-APPLE", linkName: "ApplePhoneNumber")
        mutableAttributedString.setAsLink(textToFind: "find a reseller", linkName: "FindReseller")

        tv.attributedText = mutableAttributedString
        tv.textAlignment = .center
        tv.isEditable = true
        tv.isScrollEnabled = true

        return tv
    }()

    // bottom view
    private let bottomControlStackView: UIStackView = {

        let previousButton: UIButton = {
            let b = UIButton(type: .system)
            b.setTitle("PREVIOUS", for: .normal)
            b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            b.setTitleColor(.gray, for: .normal)
            return b
        }()

        let nextButton: UIButton = {
            let b = UIButton(type: .system)
            b.setTitle("NEXT", for: .normal)
            b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
            b.setTitleColor(pinkColor, for: .normal)
            return b
        }()

        let pageControl: UIPageControl = {
            let pc = UIPageControl()
            pc.currentPage = 0
            pc.numberOfPages = 4
            let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
            pc.currentPageIndicatorTintColor = pinkColor
            pc.pageIndicatorTintColor = .gray
            return pc
        }()

        let sv = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        sv.distribution = .fillEqually
        return sv
    }()

    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swipe Pages"
        view.backgroundColor = .white

        setupViews()
    }
}

extension SwipePageController {

    private func setupViews() {

        // add top view
        view.addSubview(topContainerView)
        topContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.width / 2))
        topContainerView.addSubview(bearImageView)

        bearImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5).isActive = true

        // add midle view
        view.addSubview(TextView)
        TextView.anchor(top: topContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)

        // add bottom view
        view.addSubview(bottomControlStackView)
        bottomControlStackView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
    }
}

extension NSMutableAttributedString {

    func setAsLink(textToFind: String, linkName: String) {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: linkName, range: foundRange)
        }
    }
}
