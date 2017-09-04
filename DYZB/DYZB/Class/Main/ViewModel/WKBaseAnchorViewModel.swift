//
//  WKBaseAnchorViewModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKBaseAnchorViewModel: NSObject {

    //懒加载
    lazy var modelArray: [WKAnchorGroup] = [WKAnchorGroup]()
    
}

extension WKBaseAnchorViewModel {
    
    func loadAnchorData(isanchorGroup: Bool,urlStr: String ,parame: [String: Any]? ,finished: @escaping ()-> ()) {
        
        WKNetworkTools.requestData(url: urlStr, type: .get, parame: parame) { (result) in
            
            guard let dictData = result as? [String : Any] else {
                
                return
            }
            
            guard let dictArray = dictData["data"] as? [[String : Any]] else {
                
                return
            }
            
            if isanchorGroup == true {
            
                
                //字典转模型
                for dict in dictArray{
                    
                    self.modelArray.append(WKAnchorGroup(dict: dict))
                }
                
            }else {
            
                //字典转模型
                let groupM = WKAnchorGroup()
                
                for dict in dictArray{
                    
                    groupM.anchors.append(WKAnchorModel(dict: dict))
                    
                }
                
                self.modelArray.append(groupM)
            }

            
            finished()
        }
    }
}
