//
//  AccountViewController.swift
//  CheckTable
//
//  Created by 李　璐 on 2020/08/11.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {
    var auth: Auth!
    @IBOutlet weak var mailadderss: UILabel!
    
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func logout(_ sender: Any) {
        try? Auth.auth().signOut()
        /*let accountViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! AccountViewController
        present(accountViewController, animated: true, completion: nil)*/
    }
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let Password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: Password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                self.performSegue(withIdentifier: "TimeLine", sender: self.auth.currentUser!)
            }
             }
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            auth = Auth.auth()
            emailTextField.delegate = self
            passwordTextField.delegate = self
        }

    // 登録ボタンを押したときに呼ぶメソッド。
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if auth.currentUser != nil {
            auth.currentUser?.reload(completion: { error in
                if error == nil {
                    if self.auth.currentUser?.isEmailVerified == true {
                        self.performSegue(withIdentifier: "TimeLine", sender: self.auth.currentUser!)
                    } else if self.auth.currentUser?.isEmailVerified == false {
                        let alert = UIAlertController(title: "確認用メールを送信しているので確認をお願いします。", message: "まだメール認証が完了していません。", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! SecondViewController
        let user = sender as! User
        //nextViewController.me = AppUser(data: ["userID": user.uid])
    }

        
    @IBAction func registerAccount(_ sender: Any) {
        let email = emailTextField.text!
            let password = passwordTextField.text!
            auth.createUser(withEmail: email, password: password) { (result, error) in
                if error == nil, let result = result {
                    result.user.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            let alert = UIAlertController(title: "仮登録を行いました。", message: "入力したメールアドレス宛に確認メールを送信しました。", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
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
