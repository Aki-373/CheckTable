//
//  AccountViewController.swift
//  CheckTable
//
//  Created by 山崎峻 on 2020/08/14.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//
import UIKit
import Firebase // Firebaseをインポート
import FirebaseCore

class AccountViewController: UIViewController {
    
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var auth: Auth! // 追加

    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Auth.auth() // 追加
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    //　   登録ボタンを押したときに呼ぶメソッド。
    @IBAction func registerAccount() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error == nil, let result = result {
                // errorが nil であり、resultがnilではない == user情報がきちんと取得されている。
                self.performSegue(withIdentifier: "Timeline", sender: result.user) // 遷移先の画面でuser情報を渡している。
            }
        }
    }
    
}

// デリゲートメソッドは可読性のためextensionで分けて記述します。
extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
