//
//  NewMessageController.swift
//  projectDemo
//
//  Created by MAC on 1/7/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

final class NewMessageCell: BaseTableCell<User> {
    
    override var item: User! {
        didSet {
            textLabel?.text = item.name
            detailTextLabel?.text = item.email
        }
    }
}

final class NewMessageController: BaseTableView<NewMessageCell, User> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        fetchUser()
    }
    
    private func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded) { [weak self] (snapshot) in
            guard let this = self else { return }
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                this.items.append(user)
                DispatchQueue.main.async {
                    this.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
