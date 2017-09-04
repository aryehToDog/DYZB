//
//  WKAmuseViewModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKAmuseViewModel: WKBaseAnchorViewModel {
    
    
}

extension WKAmuseViewModel {
    
    func loadAmuseData(finished: @escaping ()-> ()) {
        //http://capi.douyucdn.cn/api/v1/getHotRoom/2

        self.loadAnchorData(isanchorGroup: true, urlStr: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parame: nil, finished: finished)
        
    }
    
}
