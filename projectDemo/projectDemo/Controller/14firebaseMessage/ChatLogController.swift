//
//  ChatLogController.swift
//  projectDemo
//
//  Created by MAC on 1/11/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

final class ChatLogController: UICollectionViewController {
    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
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
        setupInputComponents()
    }
    
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

extension ChatLogController: UITextFieldDelegate {
    
    @objc private func handleSend() {
        
        // create note key 'messages' on database
        let ref = Database.database().reference().child("messages")
        // create list key on datebase
        let childRef = ref.childByAutoId()
        let value = ["text": inputTextField.text!, "name": "Bran Stark"]
        
        // add value to database
        childRef.updateChildValues(value)
    }
    
    // fix when nhấn enter thì add value vào database
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
}
