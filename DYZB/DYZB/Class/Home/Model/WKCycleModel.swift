//
//  WKCycleModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/30.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKCycleModel: NSObject {

    var title: String = ""
    var pic_url: String = ""
    
    var room: [String : NSObject]? {
    
        didSet {
        
            guard let roomM = room else {
                return
            }
            
            anchors = WKAnchorModel(dict: roomM)
        }
    }
    
    //要初始化
    var anchors: WKAnchorModel?
    
    //字典转模型
    init(dict: [String: NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    
}
