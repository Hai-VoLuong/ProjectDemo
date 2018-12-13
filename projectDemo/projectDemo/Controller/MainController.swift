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

final class MainController: GenericTableViewController<MainCell, String> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        items = ["Parsing JSON Swift 4 with Decodable"]
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parsingJsonVC = ParsingJsonController()
        navigationController?.pushViewController(parsingJsonVC, animated: true)
    }

    @objc func handleNext() {
        navigationController?.pushViewController(ParsingJsonController(), animated: true)
    }
}
