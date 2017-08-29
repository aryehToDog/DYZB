//
//  WKBaseCollectionViewCell.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/29.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKBaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    var anchorModel: WKAnchorModel? {
        
        didSet {
            
            guard let anchorModel = anchorModel else {
                return
            }
            
            var onlineStr = ""
            if anchorModel.online > 10000 {
                
                onlineStr = "\(anchorModel.online / 10000)万在线"
            } else {
                
                onlineStr = "\(anchorModel.online)在线"
            }
            
            self.onlineBtn.setTitle(onlineStr, for: .normal)
            
            guard  let urlStr:URL = URL(string: anchorModel.vertical_src) else {
                return
            }
            
            self.iconImageView.kf.setImage(with: urlStr)
            
            self.nickNameLabel.text = anchorModel.nickname
            
        }
    }
    
}
