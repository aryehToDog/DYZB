//
//  WKCycleCell.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/30.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit
import Kingfisher

class WKCycleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!

    var cycleModel: WKCycleModel? {
    
        //进行赋值
        didSet {
        
            self.titleLable.text = cycleModel?.title
            
           let urlStr = URL(string: cycleModel?.pic_url  ?? "")!
            
            self.imageView.kf.setImage(with: urlStr, placeholder: UIImage(named: "Img_default"))
        
        }
    
    }
    
}
