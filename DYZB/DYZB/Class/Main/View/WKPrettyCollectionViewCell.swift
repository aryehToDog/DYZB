//
//  WKPrettyCollectionViewCell.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/28.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKPrettyCollectionViewCell: WKBaseCollectionViewCell {


    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchorModel: WKAnchorModel? {
        
        didSet {
            
            super.anchorModel = anchorModel
            
            self.cityBtn.setTitle(anchorModel?.anchor_city, for: .normal)
            

            
        }
    }

}
