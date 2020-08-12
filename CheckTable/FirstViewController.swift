//
//  FirstViewController.swift
//  CheckTable
//
//  Created by 甲田明寛 on 2020/08/06.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var numbers: [[String]] = [[],[],[],[]]
    
    @IBOutlet weak var book: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    
    let books : [String] = ["スタンダード","メジアン","アドバンスプラス","青チャート"]
    let bookskey = "book_title"
    var name: String!
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 1 ..< 10 {
            numbers[0].append(String(i))
        }
        for i in 1 ..< 101 {
            numbers[1].append(String(i))
        }
        for i in 1 ..< 51 {
            numbers[2].append(String(i))
        }
        for i in 1 ..< 151 {
            numbers[3].append(String(i))
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        
        collectionView.collectionViewLayout = layout
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.onLongPressAction(_:)))
        longPressRecognizer.allowableMovement = 10
        longPressRecognizer.minimumPressDuration = 0.5
        self.collectionView.addGestureRecognizer(longPressRecognizer)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        book.inputView = pickerView
        book.inputAccessoryView = toolbar
        name = books[0]
        book.text = name
    }
    
    @objc func done() {
        book.endEditing(true)
        book.text = "\(books[pickerView.selectedRow(inComponent: 0)])"
        name = "\(books[pickerView.selectedRow(inComponent: 0)])"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return numbers[0].count
        }else if section == 1{
            return numbers[1].count
        }else if section == 2{
            return numbers[2].count
        }else{
            return numbers[3].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell// 表示するセルを登録(先程命名した"Cell")
        
        cell.number.text = numbers[indexPath.section][indexPath.item]
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = 35
        return CGSize(width: cellSize, height: cellSize)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
          
        switch cell.backgroundColor {
            case UIColor.green:
                cell.backgroundColor = .lightGray
            case UIColor.lightGray:
                cell.backgroundColor = .red
            case UIColor.red:
                cell.backgroundColor = .blue
            case UIColor.blue:
                cell.backgroundColor = .green
            default:
                cell.backgroundColor = .lightGray
        }
          
    }
    
    @objc func onLongPressAction(_ sender: UILongPressGestureRecognizer) {
        //let point: CGPoint = sender.location(in: self.collectionView)
        //let indexPath = self.collectionView.indexPathForItem(at: point)
        performSegue(withIdentifier: "toAnswer",sender: nil)
    }
    
}

extension FirstViewController : UIPickerViewDelegate, UIPickerViewDataSource {
 
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return books.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return books[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.book.text = books[row]
    }

}
