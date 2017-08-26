//
//  UIColor+Extension.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/27.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
