//
//  Post.swift
//  CheckTable
//
//  Created by 山崎峻 on 2020/08/14.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore

struct Post {
    let content: String
    let postID: String
    let senderID: String
    let createdAt: Timestamp
    let updatedAt: Timestamp

    init(data: [String: Any]) {
        content = data["content"] as! String
        postID = data["postID"] as! String
        senderID = data["senderID"] as! String
        createdAt = data["createdAt"] as! Timestamp
        updatedAt = data["updatedAt"] as! Timestamp
    }
}
