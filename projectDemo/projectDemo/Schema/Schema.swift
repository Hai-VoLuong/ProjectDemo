//
//  Schema.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import UIKit
import Firebase

final class Schema { }

// home feed view controller
struct HomeFeed: Decodable {
    let videos: [Video]
}

struct Video: Decodable {
    let id: Int
    let name: String?
}

// Detail home feed view controller
struct Course: Decodable {
    let id: Int?
    let name: String?
    let duration: String?
}

// SwipePage
struct Page {
    let imageName: UIImage
    let headerText: String
    let bodyText: String
}

// group messages
struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

// firebase message
class User {
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}

class Message {
    let fromId: String?
    let text: String?
    let timeStamp: NSNumber?
    let toId: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? NSNumber ?? 0
        self.toId = dictionary["toId"] as? String ?? ""
    }
    
    func chatParterId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}

