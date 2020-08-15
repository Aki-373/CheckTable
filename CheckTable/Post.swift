//
//  Post.swift
//  CheckTable
//
//  Created by 李　璐 on 2020/08/11.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Post {
    let content: String
    let postID: String
    //let senderID: String!="a"
    let createdAt: Timestamp
    let updatedAt: Timestamp
    let book_kind: String
    let number: String
    //let url: String

    init(data: [String: Any]) {
        content = data["content"] as! String
        postID = data["postID"] as! String
        //senderID = data["senderID"] as! String
        book_kind = data["book_kind"] as! String
        //url = data["url"] as! String
        number = data["number"] as! String
        createdAt = data["createdAt"] as! Timestamp
        updatedAt = data["updatedAt"] as! Timestamp
    }
}
