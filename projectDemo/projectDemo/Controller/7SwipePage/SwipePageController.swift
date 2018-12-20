//
//  SwipePageController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SwipePageCell: BaseCollectionCell<Page> {
    
    // top view
    private let topContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private let bearImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "bear"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // midle view
    private let textView: UITextView = {
        let tv = UITextView()
        let mutableAttributedString = NSMutableAttributedString(string: "More ways to shop", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        mutableAttributedString.append(NSAttributedString(string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in out stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        tv.attributedText = mutableAttributedString
        tv.textAlignment = .center
        tv.isEditable = true
        tv.isScrollEnabled = true
        
        return tv
    }()

    override var item: Page! {
        didSet {
            bearImageView.image = item.imageName

            let mutableAttributedString = NSMutableAttributedString(string: item.headerText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])

            mutableAttributedString.append(NSAttributedString(string: "\n\n\(item.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor: UIColor.gray]))

            textView.attributedText = mutableAttributedString
            textView.textAlignment = .center
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
}

extension SwipePageCell {
    
    private func setupViews() {
        
        // add top view
        addSubview(topContainerView)
        topContainerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: 0, height: frame.width / 2))
        topContainerView.addSubview(bearImageView)
        
        bearImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        // add midle view
        addSubview(textView)
        textView.anchor(top: topContainerView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
    }
}

final class SwipePageController: BaseCollecitonView<SwipePageCell, Page>, UICollectionViewDelegateFlowLayout {

    // previousButton
    let previousButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("PREVIOUS", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(.gray, for: .normal)
        b.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return b
    }()

    @objc func handlePrev() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = prevIndex
        let indexPath = IndexPath(item: prevIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    // nextButton
    let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("NEXT", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        b.setTitleColor(pinkColor, for: .normal)
        b.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return b
    }()

    @objc func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, items.count - 1)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    // pageControl
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = items.count
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.currentPageIndicatorTintColor = pinkColor
        pc.pageIndicatorTintColor = .gray
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swipe Pages"
        collectionView.backgroundColor = .white
        items = [Page(imageName: #imageLiteral(resourceName: "bear"), headerText: "About the Teachers on Real English Conversations", bodyText: "Now, we live in Mexico. Even after moving to this country, I realized that living here and breathing in the Mexican air was not helping my Spanish skills."),
                 Page(imageName: #imageLiteral(resourceName: "heart_second"), headerText: "Understand more of what you hear", bodyText: "After taking vacations in several countries in Central and South America, we decided to follow our dreams and move to another country."),
                 Page(imageName: #imageLiteral(resourceName: "leaf_third"), headerText: "Practice speaking to use the new words you learned", bodyText: "Each lesson and activity in our courses follow one simple concept… To teach you the most important skills that make the biggest difference with your speaking and listening abilities."),
                 Page(imageName: #imageLiteral(resourceName: "bear"), headerText: "About the Teachers on Real English Conversations", bodyText: "Now, we live in Mexico. Even after moving to this country, I realized that living here and breathing in the Mexican air was not helping my Spanish skills."),
                 Page(imageName: #imageLiteral(resourceName: "heart_second"), headerText: "Understand more of what you hear", bodyText: "After taking vacations in several countries in Central and South America, we decided to follow our dreams and move to another country."),
                 Page(imageName: #imageLiteral(resourceName: "leaf_third"), headerText: "Practice speaking to use the new words you learned", bodyText: "Each lesson and activity in our courses follow one simple concept… To teach you the most important skills that make the biggest difference with your speaking and listening abilities.")]
        setupViews()
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = targetContentOffset.pointee.x / view.frame.width
        pageControl.currentPage = Int(item)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension SwipePageController {

    private func setupViews() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
        collectionView.isPagingEnabled = true

        setupBottomControler()
    }

    private func setupBottomControler() {
        let sv = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        sv.distribution = .fillEqually
        view.addSubview(sv)

        sv.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
    }
}
