//
//  ViewController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class MainCell: GenericCell<String> {

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

final class MainController: GenericTableViewController<MainCell, String> {

    override func viewDidLoad() {
        super.viewDidLoad()
        items = ["Swiping Page Feature"]
        
        view.backgroundColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let swipingVC = SwipingController()
        navigationController?.pushViewController(swipingVC, animated: true)
    }

    @objc func handleNext() {
        navigationController?.pushViewController(SwipingController(), animated: true)
    }
}
