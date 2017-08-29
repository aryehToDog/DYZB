//
//  NSdate+Extension.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/29.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

extension NSDate {

    //类函数
    class func getCurrentTime() -> String {
    
        let date = NSDate()
        let currenTime = date.timeIntervalSince1970
        
        return "\(currenTime)"
    }
}
