//
//  ViewController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class MainCell: BaseTableCell<String> {

    override var item: String! {
        didSet {
            textLabel?.text = item
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .blue
        textLabel?.textColor = .white
    }
}

final class MainController: BaseTableView<MainCell, String> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        items = ["Parsing JSON Swift 4 with Decodable",
                 "Swiping",
                 "Drag and drop video",
                 "Shimmer",
                 "Layout Stack View",
                 "Animation Label use CADisplayLink",
                 "Swipe Pages",
                 "Chain Animations for Impressive"]
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = View(rawValue: indexPath.row)?.controller() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func handleNext() {
       // handle later
    }
}

extension MainController {
    
    enum View: Int {
        case parsingJsonDecodable
        case swiping
        case dragAndDropVideo
        case shimmer
        case layoutStackView
        case animationLabel
        case swipePage
        case chainAnimation

        func controller() -> UIViewController {
            let vc: UIViewController!
            switch self {
            case .parsingJsonDecodable:
                vc = HomeFeedController()
            case .swiping:
                vc = SwipingController(collectionViewLayout: UICollectionViewFlowLayout())
            case .dragAndDropVideo:
                vc = DrapAndDropVideoController()
            case .shimmer:
                vc = ShimmerController()
            case .layoutStackView:
                vc = LayoutStackViewController()
            case .animationLabel:
                vc = AnimationLabelController()
            case .swipePage:
                vc = SwipePageController(collectionViewLayout: UICollectionViewFlowLayout())
            case .chainAnimation:
                vc = ChainAnimationController(collectionViewLayout: UICollectionViewFlowLayout())
            }
            return vc
        }
    }
}
