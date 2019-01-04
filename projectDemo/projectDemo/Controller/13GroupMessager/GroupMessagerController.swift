//
//  GroupMessagerController.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

extension Date {
    
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }

}

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
            bubbleBackgroundView.backgroundColor = item.isIncoming ? .white : .green
            
            // check left of right of messages
            if item.isIncoming {
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

        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
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
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .green
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    // get data from server
    let messagesFromServer = [
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Yo, dawg, Whaddup!", isIncoming: false, date: Date()),
        ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Third Section message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018"))
    ]

    var chatMessages = [[ChatMessage]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups Messager"
        view.backgroundColor = .white
        setupTableView()
        getDataFromServer()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let messageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: messageInSection.date)
            
            let dateLabel = DateHeaderLabel()
            dateLabel.text = dateString
            
            let containerView = UIView()
            containerView.addSubview(dateLabel)
            
            dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GroupMessagerCell
        cell.item = chatMessages[indexPath.section][indexPath.row]
        return cell
    }
}

extension GroupMessagerController {
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    private func getDataFromServer() {
        
        // group messages theo ngày tháng năm
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date.reduceToMonthDayYear()
        }

        // sort message
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
    }
}
