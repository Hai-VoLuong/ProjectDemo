//
//  NewItemController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/17/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class NewItemCell: BaseTableCell<String> {

    override var item: String! {
        didSet {
            // use muti text in cell
            textLabel?.numberOfLines = 0
            textLabel?.font = UIFont.systemFont(ofSize: 18)
            textLabel?.text = item
        }
    }
}

final class NewItemController: BaseTableView<NewItemCell, String> {

    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            "As a developer whose first programming language is Swift, I've taken online courses from major platforms.",
            "However, I have been frustrated by a lack of detailed explanations from instructors. They tend to focus on final products, thus missing out the fundamentals. I was confused by which design principles to follow, and why.",
            "After I've been blogging for the last 5 months, I've discovered this isn't the only problem of mine.",
            "I've received hundreds of emails and questions regarding how to write code that does not violate principles such as DRY, modularity, and readability.",
            "As a developer whose first programming language is Swift, I've taken online courses from major platforms.",
            "However, I have been frustrated by a lack of detailed explanations from instructors. They tend to focus on final products, thus missing out the fundamentals. I was confused by which design principles to follow, and why.",
            "After I've been blogging for the last 5 months, I've discovered this isn't the only problem of mine.",
            "I've received hundreds of emails and questions regarding how to write code that does not violate principles such as DRY, modularity, and readability.",
            "As a developer whose first programming language is Swift, I've taken online courses from major platforms.",
            "However, I have been frustrated by a lack of detailed explanations from instructors. They tend to focus on final products, thus missing out the fundamentals. I was confused by which design principles to follow, and why.",
            "After I've been blogging for the last 5 months, I've discovered this isn't the only problem of mine.",
            "I've received hundreds of emails and questions regarding how to write code that does not violate principles such as DRY, modularity, and readability.",
            ]

        setupViews()
    }
}

extension NewItemController {

    private func setupViews() {
        tableView.backgroundColor = .white
        tableView.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        tableView.tableFooterView = footerView
    }
}
