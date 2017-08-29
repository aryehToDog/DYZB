//
//  WKAnchorModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/29.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKAnchorModel: NSObject {

    //房间id
    var room_id: Int = 0
    
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical  : Int = 0
    
    /// 房间名称
    var room_name : String = ""
    
    /// 主播昵称
    var nickname : String = ""
    
    /// 观看人数
    var online : Int = 0
    
    /// 所在城市
    var anchor_city : String = ""
    
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //字典转模型
    init(dict: [String: NSObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
