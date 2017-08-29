//
//  WKReusableView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/28.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKReusableView: UICollectionReusableView {

    @IBOutlet weak var iconView: UIImageView!

    @IBOutlet weak var nickNameLable: UILabel!
    
    
    var anchorM: WKAnchorGroup? {
    
        didSet {
    
            self.iconView.image = UIImage(named: (anchorM?.icon_name ?? ""))
            
            self.nickNameLable.text = anchorM?.tag_name
    }
    
    }
    
    
}
