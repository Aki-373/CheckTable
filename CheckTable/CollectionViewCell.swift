//
//  CollectionViewCell.swift
//  CheckTable
//
//  Created by 甲田明寛 on 2020/08/09.
//  Copyright © 2020 Akihiro Koda. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var number: UILabel!
    
    var title: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // cellの枠の太さ
        self.layer.borderWidth = 1.0
        // cellの枠の色
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}
