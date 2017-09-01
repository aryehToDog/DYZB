//
//  WKGameViewModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/1.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKGameViewModel {
    
    //懒加载
    lazy var gameModelArray: [WKGameModel] = [WKGameModel]()
    
}

extension WKGameViewModel {

    func loadGameData(finished: @escaping ()-> ()) {
    
        WKNetworkTools.requestData(url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", type: .get, parame: ["shortName" : "game"]) { (result) in
            
            guard let dictData = result as? [String : Any] else {
            
                return
            }
            
            guard let dictArray = dictData["data"] as? [[String : Any]] else {
            
                return
            }
            
            //字典转模型
            for dict in dictArray{
            
                self.gameModelArray.append(WKGameModel(dict: dict))
            }
            
            finished()
            
            
        }
        
    }

}
