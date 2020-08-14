//
//  TimelineViewController.swift
//  CheckTable
//
//  Created by 山崎峻 on 2020/08/14.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//


import UIKit
import Firebase
import FirebaseCore
// デリゲート・データソースを記述。
class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var me: AppUser!
    var database: Firestore! // 宣言
    
    @IBOutlet var tableView: UITableView! // 追加

    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        tableView.delegate = self  // 追加
        tableView.dataSource = self // 追加
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = postArray[indexPath.row].content
        return cell
    }
    

//////////

    // 投稿追加画面に遷移するボタンを押したときの動作を記述。
    @IBAction func toAddViewController() {
        performSegue(withIdentifier: "Add", sender: me)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddViewController // segue.destinationで遷移先のViewControllerが取得可能。
        destination.me = sender as! AppUser
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database.collection("posts").getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                self.postArray = []
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.append(post)
                }
                self.tableView.reloadData() // 先ほど書いたprint文をこちらに変更
            }
        }
    }
}

