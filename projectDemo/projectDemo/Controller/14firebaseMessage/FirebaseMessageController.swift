//
//  firebaseMessageController.swift
//  projectDemo
//
//  Created by MAC on 1/4/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit

final class FirebaseMessageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc private func handleLogout() {
        
    }
}
