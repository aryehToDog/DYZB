//
//  WKBaseGameModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/1.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKBaseGameModel: NSObject {

    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //字典转模型
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
