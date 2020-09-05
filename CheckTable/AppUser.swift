//
//  AppUser.swift
//  CheckTable
//
//  Created by 李　璐 on 2020/08/11.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import Foundation
import Firebase

struct AppUser {
    let userID: String
    let followingUser: [String]
    let followedUser: [String]
    let likePosts: [String]
    //let userName: String

    init(data: [String: Any]) {
        userID = data["userID"] as! String
        followingUser = []
        followedUser = []
        likePosts = []
        //userName = data["userName"] as! String
    }
}
