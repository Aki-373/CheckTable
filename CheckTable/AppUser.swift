//
//  AppUser.swift
//  CheckTable
//
//  Created by 山崎峻 on 2020/08/14.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore

struct AppUser {
    let userID: String
    let userName: String

    init(data: [String: Any]) {
        userID = data["userID"] as! String
        userName = data["userName"] as! String
    }
}
