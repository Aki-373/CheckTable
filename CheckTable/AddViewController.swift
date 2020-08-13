//
//  AddViewController.swift
//  CheckTable
//
//  Created by 李　璐 on 2020/08/11.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    
    var me: AppUser!

    //override func viewDidLoad() {
        //super.viewDidLoad()
    //}

    @IBOutlet weak var book_kind: UITextField!
    
    @IBOutlet weak var number: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    let list: [String] = ["アドバンスプラス", "青チャート", "フォーカスゴールド", "東大25年"]
    let Array = [Int](1...90)
    override func viewDidLoad() {
           super.viewDidLoad()
        contentTextView.layer.borderWidth = 0.5
           // ピッカー設定
           pickerView.delegate = self
           pickerView.dataSource = self
           pickerView.showsSelectionIndicator = true
           
           // 決定バーの生成
           let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
           let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
           let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
           toolbar.setItems([spacelItem, doneItem], animated: true)
           
           // インプットビュー設定
           book_kind.inputView = pickerView
           book_kind.inputAccessoryView = toolbar
        number.inputView=pickerView
        number.inputAccessoryView=toolbar
       }
       
       // 決定ボタン押下
       @objc func done() {
           book_kind.endEditing(true)
           book_kind.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
    }
    @IBAction func postContent(_ sender: Any) {
        let content = contentTextView.text!
        let book = book_kind.text!
        let quiz_num = number.text!
        let saveDocument = Firestore.firestore().collection("posts").document()
        saveDocument.setData([
            "content": content,
            "postID": saveDocument.documentID,
            //"senderID": user.uid,
            "book_kind": book,
            "number": quiz_num,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]) { error in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func setupTextView() {
        let toolBar = UIToolbar() // キーボードの上に置くツールバーの生成
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // 今回は、右端にDoneボタンを置きたいので、左に空白を入れる
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard)) // Doneボタン
        toolBar.items = [flexibleSpaceBarButton, doneButton] // ツールバーにボタンを配置
        toolBar.sizeToFit()
        contentTextView.inputAccessoryView = toolBar // テキストビューにツールバーをセット
    }

    // キーボードを閉じる処理。
    @objc func dismissKeyboard() {
        contentTextView.resignFirstResponder()
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
extension AddViewController : UIPickerViewDelegate, UIPickerViewDataSource {
 
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
         if component == 0 {return list.count
         } else {
            return Array.count
         }
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {return list[row]
        } else {
           return String(Array[row])
        }
    }
    
    
    // ドラムロール選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            book_kind.text = list[row]
        case 1:
            number.text = String(Array[row])
        default:
            break
        }
    }
     
}

