//
//  AppDelegate.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        registerPushNotification()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        window?.rootViewController = UINavigationController(rootViewController: MainController())
        return true
    }
    
    
    /// Phương thức requestAuthorization kích hoạt một alert view hỏi người dùng có muốn nhận thông báo hay là không.
    
    /// granted cho bạn biết rằng user có đồng ý hay từ chối nhận push
    private func registerPushNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, err) in
            if err != nil {
                print(err?.localizedDescription ?? "error")
            }
            print("granted: \(granted)")
        }
    }
}
