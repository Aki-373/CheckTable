//
//  SubViewController.swift
//  CheckTable
//
//  Created by 李　璐 on 2020/08/15.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import Foundation
 
import UIKit
 
class SubViewController: UIViewController{
 
    @IBOutlet weak var imageView: UIImageView!
    var selectedImg: UIImage!
    
       override func viewDidLoad() {
           super.viewDidLoad()
    
           imageView.image = selectedImg
           // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
           imageView.contentMode = UIView.ContentMode.scaleAspectFit
    
       }
}
