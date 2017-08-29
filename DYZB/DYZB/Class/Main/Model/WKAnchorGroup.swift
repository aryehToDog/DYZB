//
//  WKAnchorGroup.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/29.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKAnchorGroup: NSObject {
    
    //保存WKAnchorModel 中的模型
    lazy var anchors: [WKAnchorModel] = [WKAnchorModel]()
    
    //改组中对应的房间信息 [字典数组]
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return}
            
            //添加WKAnchorModel 模型
            for dict in room_list {    
                anchors.append(WKAnchorModel(dict: dict))
            }
            
        }
        
    }
    
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //组显示的标题
    var icon_name: String = "home_header_normal"

    //字典转模型
    override init() {
        
    }
    
     init(dict: [String: NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
