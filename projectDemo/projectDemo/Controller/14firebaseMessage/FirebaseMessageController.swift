//
//  firebaseMessageController.swift
//  projectDemo
//
//  Created by MAC on 1/4/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

final class FirebaseMessageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserIsLoggedIn()
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observe(.value) { [weak self] (snapshot) in
                guard let this = self else { return }
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    this.navigationItem.title = dictionary["name"] as? String
                }
            }
        }
    }
    
    @objc private func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = LoginController()
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func handleNewMessage() {
        let newMessageVC = NewMessageController()
        let naviController = UINavigationController(rootViewController: newMessageVC)
        present(naviController, animated: true, completion: nil)
    }
}
