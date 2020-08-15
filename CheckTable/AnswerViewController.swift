//
//  AnswerViewController.swift
//  CheckTable
//
//  Created by 甲田明寛 on 2020/08/15.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AnswerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var key:[Int]!
    let list: [String] = ["アドバンスプラス", "青チャート", "フォーカスゴールド", "東大25年"]
    var database: Firestore! // 宣言
    var postArray: [Post] = []
    
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
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        let kind = key[0]
        let numberOfProblem = key[1] + 1
        for i in 0..<postArray.count{
            if(postArray[i].book_kind==list[kind] && postArray[i].number==String(numberOfProblem)){
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kind = key[0]
        let numberOfProblem = key[1] + 1
        var selected:[Int] = []
        for i in 0..<postArray.count{
            if(postArray[i].book_kind==list[kind] && postArray[i].number==String(numberOfProblem)){
                selected.append(i)
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
            cell.textLabel?.text = postArray[selected[indexPath.row]].content
        cell.detailTextLabel?.text =  postArray[selected[indexPath.row]].book_kind + postArray[indexPath.row].number
        return cell
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
