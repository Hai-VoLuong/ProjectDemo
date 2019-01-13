//
//  ChatLogController.swift
//  projectDemo
//
//  Created by MAC on 1/11/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

final class ChatLogCell: BaseCollectionCell<Message> {
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.text = "adfdadfda"
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    override var item: Message! {
        didSet {
            textView.text = item.text
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(textView)
        textView.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 250, height: frame.height))
    }
}

final class ChatLogController: BaseCollecitonView<ChatLogCell, Message>, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
            observeMessages()
        }
    }
    
    private func observeMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userMessageRef = Database.database().reference().child("user-messages").child(uid)
        userMessageRef.observe(.childAdded, with: {[weak self] (snapshot) in
            guard let this = self else { return }
            let messageId = snapshot.key
            let messsageRef = Database.database().reference().child("messages").child(messageId)
            messsageRef.observe(.value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let message = Message(dictionary: dictionary)
                
                if message.chatParterId() == this.user?.id {
                    this.items.append(message)
                    DispatchQueue.main.async {
                        this.collectionView.reloadData()
                    }
                }
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var sendButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("send", for: .normal)
        b.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return b
    }()
    
    @objc private func handleSend() {
        
        // create note key 'messages' on database
        let ref = Database.database().reference().child("messages")
        // create list key on datebase
        let childRef = ref.childByAutoId()
        let toId = user!.id!
        let fromId = Auth.auth().currentUser!.uid
        let timeStamp: Int = Int(Date().timeIntervalSince1970)
        
        let value = ["text": inputTextField.text!,
                     "toId": toId,
                     "fromId": fromId,
                     "timeStamp": timeStamp] as [String : Any]
        
        // create tabel user-messages
        childRef.updateChildValues(value) { (err, ref) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            // get userId người gởi add into table user-messages
            let userMessageRef = Database.database().reference().child("user-messages").child(fromId)
            
            //get messageId add into table user-messages
            let messageId = childRef.key
            userMessageRef.updateChildValues([messageId: 1])
            
            // get userId người nhận add into table-messages
            let recipientUserMessageRef = Database.database().reference().child("user-messages").child(toId)
            recipientUserMessageRef.updateChildValues([messageId: 1])
        }
    }
    
    // fix when nhấn enter thì add value vào database
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }

    private lazy var inputTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Enter Message..."
        return tf
    }()
    
    private let separatorLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 220/255, green: 225/255, blue: 225/255, alpha: 1)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        setupInputComponents()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}

extension ChatLogController {
    
    private func setupInputComponents() {
        view.addSubview(containerView)
        containerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, size: .init(width: view.frame.width, height: 50))
        
        containerView.addSubview(sendButton)
        sendButton.anchor(top: nil, leading: nil, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16),size: CGSize(width: 40, height: containerView.frame.height))
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerView.addSubview(inputTextField)
        inputTextField.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: sendButton.leadingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerView.addSubview(separatorLineView)
        separatorLineView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, size: CGSize(width: 0, height: 1))
    }
}
