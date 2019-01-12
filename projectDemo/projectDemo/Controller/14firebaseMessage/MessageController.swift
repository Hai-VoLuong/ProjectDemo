//
//  firebaseMessageController.swift
//  projectDemo
//
//  Created by MAC on 1/4/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

final class MessageCell: BaseTableCell<Message> {
    
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
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    private let timeLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 13)
        l.textColor = .darkGray
        l.text = "HH:MM:SS"
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: titleLabel.frame.width, height: titleLabel.frame.height))
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: descriptionLabel.frame.width, height: descriptionLabel.frame.height))
        
        addSubview(timeLabel)
        timeLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 100, height: titleLabel.frame.height))
    }


    override var item: Message! {
        didSet {
            if let toId = item.chatParterId() {
                let ref = Database.database().reference().child("users").child(toId)
                ref.observe(.value) { [weak self] (snapshot) in
                    guard let this = self else { return }
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        this.titleLabel.text = dictionary["name"] as? String
                    
                        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                            this.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
                        }
                    }
                }
            }

            if let seconds = item.timeStamp?.doubleValue {
                let timeStampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timeStampDate as Date)
            }
            descriptionLabel.text = item.text
        }
    }
}

final class MessageController: BaseTableView<MessageCell, Message> {
    
    // group message
    var messagesDictionary = [String: Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserIsLoggedIn()
        //observeMessages()
    }
    
    private func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            // get table message from table user_messages
            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(messageId)
            
            messagesRef.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                guard let this = self else { return }
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message(dictionary: dictionary)
                    if let toId = message.toId {
                        this.messagesDictionary[toId] = message
                        this.items = Array(this.messagesDictionary.values)
                        
                        // sort theo time stamp
                        this.items.sorted { (message1, message2) -> Bool in
                            return message1.timeStamp!.intValue > message2.timeStamp!.intValue
                        }
                    }
                    DispatchQueue.main.async {
                        this.tableView.reloadData()
                    }
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    private func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { [weak self] (snapshot) in
            guard let this = self else { return }
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message(dictionary: dictionary)
                if let toId = message.toId {
                    this.messagesDictionary[toId] = message
                    this.items = Array(this.messagesDictionary.values)
                    
                    // sort theo time stamp
                    this.items.sorted { (message1, message2) -> Bool in
                        return message1.timeStamp!.intValue > message2.timeStamp!.intValue
                    }
                }
                DispatchQueue.main.async {
                    this.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        } else {
            fetchUserAndSetupNaviBarTitle()
        }
    }
    
    func fetchUserAndSetupNaviBarTitle() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observe(.value) { [weak self] (snapshot) in
            guard let this = self else { return }
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                this.setupNavBarWithUser(user)
            }
        }
    }
    
    func setupNavBarWithUser(_ user: User) {
        messagesDictionary.removeAll()
        tableView.reloadData()
        observeUserMessages()
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
    
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        
        containerView.addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let nameLabel = UILabel()
        
        containerView.addSubview(nameLabel)
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        navigationItem.titleView = titleView
//        navigationController?.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController(user:))))
        
    }
    
    func showChatController(user: User) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewLayout())
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
    }

    @objc private func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = LoginController()
        loginVC.messageController = self
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func handleNewMessage() {
        let newMessageVC = NewMessageController()
        newMessageVC.messageController = self
        let naviController = UINavigationController(rootViewController: newMessageVC)
        present(naviController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
