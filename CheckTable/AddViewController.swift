//
//  AddViewController.swift
//  CheckTable
//
//  Created by 李　璐 on 2020/08/11.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AddViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var contentTextView: UITextView!
    
    var me: AppUser!

    @IBOutlet weak var book_kind: UITextField!
    
    @IBOutlet weak var number: UITextField!
    
    @IBAction func camera(_ sender: Any) {
        let pickerController = UIImagePickerController()

        //ソースタイプを指定(cameraの場合はplistでカメラ使用を許可すること)
        pickerController.sourceType = .camera

        //カメラを表示
        present(pickerController, animated: true, completion: nil)
    }
    var pickerView: UIPickerView = UIPickerView()
    let list: [String] = ["アドバンスプラス", "青チャート", "フォーカスゴールド", "東大25年"]
    let Array = [Int](1...90)
    override func viewDidLoad() {
           super.viewDidLoad()
           imagePicker.delegate = self
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
        number.endEditing(true)
        number.text = "\(Array[pickerView.selectedRow(inComponent: 1)])"
    }
    @IBAction func presentImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = true //画像の切り抜きが出来るようになります。
        imagePicker.sourceType = .photoLibrary //画像ライブラリを呼び出します
        present(imagePicker, animated: true, completion: nil)
    }
    
    //fileprivate
    open func upload(completed: @escaping(_ url: String?) -> Void){
        let date = NSDate()
        let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("images").child("\(currentTimeStampInSecond).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = self.imageView.image?.jpegData(compressionQuality: 0.9) {
            storageRef.putData(uploadData, metadata: metaData) { (metadata , error) in
                if error != nil {
                    completed(nil)
                    print("error: \(error?.localizedDescription)")
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        completed(nil)
                        print("error: \(error?.localizedDescription)")
                    }
                    completed(url?.absoluteString)
                })
            }
        }
    }
    
    @IBAction func postContent(_ sender: Any) {
        var data1: Dictionary<String, Any>! = [:]
        let content = contentTextView.text!
        let book = book_kind.text!
        let quiz_num = number.text!
        let saveDocument = Firestore.firestore().collection("posts").document()
        upload(){ url in
            guard let url = url else {return }
            data1["URL"] = url
            data1["content"] = content
            data1["postID"] = saveDocument.documentID
            data1["book_kind"] = book
            data1["number"] = quiz_num
            data1["createdAt"] = FieldValue.serverTimestamp()
            data1["updatedAt"] = FieldValue.serverTimestamp()
            saveDocument.setData(data1!)
        {error in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }
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

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
