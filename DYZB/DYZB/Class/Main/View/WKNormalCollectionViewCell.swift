//
//  WKNormalCollectionViewCell.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/28.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit
import Kingfisher
class WKNormalCollectionViewCell: WKBaseCollectionViewCell {

    @IBOutlet weak var roomNameLabel: UILabel!

   override var anchorModel: WKAnchorModel? {
    
        didSet {
        
            super.anchorModel = anchorModel
            
            self.roomNameLabel.text = anchorModel?.room_name
        }
    }

}
