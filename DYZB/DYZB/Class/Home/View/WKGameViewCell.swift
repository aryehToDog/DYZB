//
//  WKGameViewCell.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/31.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit
import Kingfisher

class WKGameViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var groupM: WKBaseGameModel? {
        
        didSet {
            
            self.titleLable.text = groupM?.tag_name
            
            guard let urlS: URL = URL(string: groupM?.icon_url ?? "") else {
            
                return
            }
            self.imageView.kf.setImage(with: urlS, placeholder: UIImage(named: "home_more_btn"))
            
        }
    }
    
    
}
