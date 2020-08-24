//
//  SecondViewController.swift
//  CheckTable
//
//  Created by 甲田明寛 on 2020/08/06.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SecondViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    var selectedImage : UIImage?
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = getImageByUrl(url: postArray[indexPath.row].url)
        
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toSubViewController",sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count //postArray.count
    }
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        tableView.rowHeight = 400
            //print(postArray[indexPath.row].content)
        let Context = cell.viewWithTag(1) as! UILabel
        let Where = cell.viewWithTag(2) as! UILabel
        let answer = cell.viewWithTag(3) as! UIImageView
        let name = cell.viewWithTag(4) as! UILabel
        let imageFileUrl = postArray[indexPath.row].url
        Context.text = postArray[indexPath.row].content
        Where.text =  postArray[indexPath.row].book_kind + " 第" + postArray[indexPath.row].number + "問"
        let Image:UIImage = getImageByUrl(url: imageFileUrl)
        answer.image = Image
        database.collection("users").document(postArray[indexPath.row].senderID).getDocument { (snapshot, error) in
            if error == nil, let snapshot = snapshot, let data = snapshot.data() {
                let appUser = AppUser(data: data)
                name.text = appUser.userName // 今回は、ユーザー名をdetailTextLabelに表示。
            }
        }
        return cell
    }
    
    var me: AppUser!
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
        database.collection("users").document(me.userID).setData([
        "userID": me.userID
        ], merge: true)
        database.collection("users").document(me.userID).getDocument { (snapshot, error) in
            if error == nil, let snapshot = snapshot, let data = snapshot.data() {
                self.me = AppUser(data: data)
            }
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
    }
        // 投稿追加画面に遷移するボタンを押したときの動作を記述。

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    let destination = segue.destination as! AddViewController // segue.destinationで遷移先のViewControllerが取得可能。
        destination.me = sender as! AppUser
        if (segue.identifier == "toSubViewController") {
                   let subVC: SubViewController = (segue.destination as? SubViewController)!
        
                   // SubViewController のselectedImgに選択された画像を設定する
                   subVC.selectedImg = selectedImage
               }
    }
    @IBAction func toAddViewController(_ sender: Any) {
        performSegue(withIdentifier: "Add", sender: me)
    }
}
extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
