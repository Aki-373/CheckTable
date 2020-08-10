//
//  FirstViewController.swift
//  CheckTable
//
//  Created by 甲田明寛 on 2020/08/06.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var numbers = [String]()
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 1 ..< 200 {
            numbers.append(String(i))
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell// 表示するセルを登録(先程命名した"Cell")
        
        cell.number.text = numbers[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = 35
        return CGSize(width: cellSize, height: cellSize)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
          if(cell.color == 3){
              cell.color = 0
          }else{
              cell.color += 1
          }
          
          switch cell.color {
          case 0:
            cell.backgroundColor = .lightGray
          case 1:
              cell.backgroundColor = .red
          case 2:
              cell.backgroundColor = .blue
          case 3:
              cell.backgroundColor = .green
          default:
              cell.backgroundColor = .darkGray
          }
          
          print(cell.color)
    }
    
    
}
