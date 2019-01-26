//
//  LocalPushNotificationController.swift
//  projectDemo
//
//  Created by MAC on 1/26/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import UserNotifications

final class LocalPushNotificationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Local PushNotification"
        view.backgroundColor = .white
        
        testReceiveLocalNotification()
    }
    
    /// định nghĩa một thời gian mà bạn sẽ phát ra thông báo.
    /// Ví dụ ở trên là 5 giây sau khi bạn đặt hẹn phát.
    /// Repeats là bạn muốn lặp lại thông báo không mà thôi.
    /// ngoài ra: còn có
    /// UNCalendarNotificationTrigger Trigger cho phép bạn hẹn ngày, thời gian để phát thông báo.
    /// UNLocationNotificationTrigger Trigger địa điểm. Khi user đến một địa điểm nào đó thì sẽ có thông báo.
    private func testReceiveLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Đây là cái title"
        content.body = "Đây là cái nội dung."
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // create request
        let request = UNNotificationRequest(identifier: "Test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
