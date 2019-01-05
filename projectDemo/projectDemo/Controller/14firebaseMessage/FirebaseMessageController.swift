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
        
//        let ref = Database.database().reference(fromURL: "https://projectdemo-aac9e.firebaseio.com/")
//        ref.updateChildValues(["SomeValue" : 12345])
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc private func handleLogout() {
        let loginVC = LoginController()
        present(loginVC, animated: true, completion: nil)
    }
}
