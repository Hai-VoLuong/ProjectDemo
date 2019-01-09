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
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        return l
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "course_banner")
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: titleLabel.frame.width, height: titleLabel.frame.height))
        //titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: descriptionLabel.frame.width, height: descriptionLabel.frame.height))
        //descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    override var item: User! {
        didSet {
            titleLabel.text = item.name
            descriptionLabel.text = item.email
            
            if let profileImageUrl = item.profileImageUrl {
                let url = URL(string: profileImageUrl)
            
                URLSession.shared.dataTask(with: url!) { [weak self] (data, response, err) in
                    guard let this = self else { return }
                    if let err = err {
                        print(err.localizedDescription)
                        return
                    }
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.async {
                            this.profileImageView.image = UIImage(data: data!)
                        }
                    }
                }.resume()
            }
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
