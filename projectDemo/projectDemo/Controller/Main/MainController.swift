//
//  ViewController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class MainCell: GenericTableCell<String> {

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

final class MainController: GenericTableView<MainCell, String> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        items = ["Parsing JSON Swift 4 with Decodable",
                 "Swiping"]
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let view = View(rawValue: indexPath.row) else { return }
        let vc = controller(view: view)
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
    }
    
    private func controller(view: View) -> UIViewController {
        let vc: UIViewController!
        switch view {
        case .parsingJsonDecodable:
            vc = HomeFeedController()
            return vc
        case .swiping:
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            vc = SwipingController(collectionViewLayout: layout)
            return vc
        }
    }
}
