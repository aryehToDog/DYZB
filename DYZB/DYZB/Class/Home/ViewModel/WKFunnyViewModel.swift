//
//  WKFunnyViewModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/4.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKFunnyViewModel: WKBaseAnchorViewModel {


}

extension WKFunnyViewModel {

    func loadFunnyData(finished: @escaping ()-> ())  {
    
        self.loadAnchorData(isanchorGroup: false, urlStr: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parame: ["limit" : 30, "offset" : 0], finished: finished)
    
    }

}
