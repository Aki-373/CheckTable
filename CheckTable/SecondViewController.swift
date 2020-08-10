//
//  SecondViewController.swift
//  CheckTable
//
//  Created by 甲田明寛 on 2020/08/06.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {

    var me: AppUser!
    var database: Firestore! // 宣言

    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore() // 初期値代入
    }

    // 投稿追加画面に遷移するボタンを押したときの動作を記述。
    
    @IBAction func toAddViewController(_ sender: Any) {
        performSegue(withIdentifier: "Add", sender: me)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddViewController // segue.destinationで遷移先のViewControllerが取得可能。
        destination.me = sender as! AppUser
    }
}

