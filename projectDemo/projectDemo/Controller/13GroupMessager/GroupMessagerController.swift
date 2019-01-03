//
//  GroupMessagerController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class GroupMessagerCell: BaseTableCell<String> {
    
    private let messageLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        //l.backgroundColor = .green
//l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let bubbleBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
        v.layer.cornerRadius = 5
       // v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override var item: String! {
        didSet {
            messageLabel.text = item
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        
        messageLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 32, left: 32, bottom: 32, right: 0), size: .init(width: 250, height: 0))
        
        bubbleBackgroundView.anchor(top: messageLabel.topAnchor, leading: messageLabel.leadingAnchor, bottom: messageLabel.bottomAnchor, trailing: messageLabel.trailingAnchor, padding: .init(top: -16, left: -16, bottom: -16, right: -16))
//
//        addSubview(bubbleBackgroundView)
//        addSubview(messageLabel)
//
//        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
//                           messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
//                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
//                           messageLabel.widthAnchor.constraint(equalToConstant: 250),
//
//                           bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
//                           bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
//                           bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
//                           bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
//                           ]
//        NSLayoutConstraint.activate(constraints)
    }
}

final class GroupMessagerController: BaseTableView<GroupMessagerCell, String> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups Messager"
        view.backgroundColor = .white
        items = ["Here's my very first message",
                 "I'm going to message another long message that will word wrap",
                 "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap",
                 "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap"
                 ]
        tableView.separatorStyle = .none
    }
}

