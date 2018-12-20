//
//  Schema.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import UIKit

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

