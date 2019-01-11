//
//  AppDelegate.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        window?.rootViewController = UINavigationController(rootViewController: MainController())
        return true
    }
}
