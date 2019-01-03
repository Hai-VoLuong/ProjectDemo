//
//  GroupMessagerController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class GroupMessagerCell: BaseTableCell<ChatMessage> {
    
    private let messageLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let bubbleBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // check left or right of message
    var leadingConstraint: NSLayoutConstraint!
    var trailingAnchorConstraint: NSLayoutConstraint!
    
    override var item: ChatMessage! {
        didSet {
            messageLabel.text = item.text
            messageLabel.textColor = item.isInComing ? .black : .white
            bubbleBackgroundView.backgroundColor = item.isInComing ? .white : .darkGray
            
            // check left of right of messages
            if item.isInComing {
                leadingConstraint.isActive = true
                trailingAnchorConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingAnchorConstraint.isActive = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)

        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
                        
                           bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                           bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                           bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
                           ]
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingAnchorConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
    }
}

final class GroupMessagerController: BaseTableView<GroupMessagerCell, ChatMessage> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups Messager"
        view.backgroundColor = .white
        items = [
            ChatMessage(text: "Here's my very first message", isInComing: true),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isInComing: true),
            ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isInComing: true),
            ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isInComing: false),
            ChatMessage(text: "Yo!. i have a geay", isInComing: false),
        ]
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.register(GroupMessagerCell.self, forCellReuseIdentifier: cellId)
    }
}

