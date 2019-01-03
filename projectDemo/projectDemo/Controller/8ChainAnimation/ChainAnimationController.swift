//
//  ChainAnimationController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/20/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
final class ChainAnimationController: BaseCollecitonView<ChainAnimationCell, Page>, UICollectionViewDelegateFlowLayout {
    
    // previousButton
    private let previousButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("PREVIOUS", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(.lightGray, for: .normal)
        b.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return b
    }()
    
    @objc private func handlePrev() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = prevIndex
        let indexPath = IndexPath(item: prevIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // nextButton
    private let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("NEXT", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(.black, for: .normal)
        b.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return b
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, items.count - 1)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // pageControl
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = items.count
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        sv.distribution = .fillEqually
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = "Chain Animations"
        navigationController?.navigationBar.prefersLargeTitles = true
        items = [Page(imageName: #imageLiteral(resourceName: "bear"), headerText: "Welcome", bodyText: "Hi, Hai!\nThanks for downloading our application."),
                 Page(imageName: #imageLiteral(resourceName: "bear"), headerText: "Awesome People", bodyText: "We work hard every day to make sure you don't have to."),
                 Page(imageName: #imageLiteral(resourceName: "bear"), headerText: "Mission Statement", bodyText: "Here at company XYZ, no stone is left unturned when looking for the BEST Solutions."),
                 Page(imageName: #imageLiteral(resourceName: "bear"), headerText: "Leave us a message", bodyText: "Don't forget to give us feedback on what you'd like to see in the future!\n\nContact:\nwww.letsbuildthatapp.com")]
        setupViews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChainAnimationCell
        cell.delegate = self
        cell.item = items[indexPath.item]
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = targetContentOffset.pointee.x / view.frame.width
        pageControl.currentPage = Int(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
}

extension ChainAnimationController {
    
    private func setupViews() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
        collectionView.isPagingEnabled = true
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
    }
}

extension ChainAnimationController: ChainAnimationCellProtocol {
    
    func scrollToItem() {
        guard let currentCell = collectionView?.visibleCells.first,
            let index = collectionView?.indexPath(for: currentCell)?.item else { return }
        
        let nextIndex = min(index + 1, items.count - 1)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
