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
    let userName: String! = "a"

    init(data: [String: Any]) {
        userID = data["userID"] as! String
        //userName = data["userName"] as! String
    }
}
