//
//  WKRecommendViewModel.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/29.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//  MVVM 用来网络数据请求所用

import UIKit

class WKRecommendViewModel: WKBaseAnchorViewModel {
    
    //保存WKCycleModel 的数组
    lazy var cycleModel: [WKCycleModel] = [WKCycleModel]()
    
    //保存颜值的模型
    var prettyAnchorGroup: WKAnchorGroup = WKAnchorGroup()
    
    //保存热门的模型
    var hotAnchorGroup: WKAnchorGroup = WKAnchorGroup()
}


extension WKRecommendViewModel {
    
    /// 用来网络数据请求所用
    func loadData(finished: @escaping () -> ()) {
        
        let parame = ["limit" : "4",
                      "offset" : "0",
                      "time" : NSDate.getCurrentTime()]
        
        let disPathGroup = DispatchGroup()
    
        //发送网络数据
        //获取01组的数据
        
        //进入组
        disPathGroup.enter()
        WKNetworkTools.requestData(url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parame: parame as [String : NSObject]) { (result) in
            
            guard let dictResult = result as? [String: NSObject] else {
                
                return
            }
            
            guard let dictArray = dictResult["data"] as? [[String : NSObject]] else {
                
                return
            }
            
            self.hotAnchorGroup.tag_name = "热门"
            self.hotAnchorGroup.icon_name = "home_header_hot"
            
            for dict in dictArray {
                
                self.hotAnchorGroup.anchors.append(WKAnchorModel(dict: dict))
            }
            
            //离开
            disPathGroup.leave()
        }
        
        //进入组
        disPathGroup.enter()
        
        //获取02组的数据
        WKNetworkTools.requestData(url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parame: parame as [String : NSObject]) { (result) in
            
            guard let dictResult = result as? [String: NSObject] else {
                
                return
            }
            
            guard let dictArray = dictResult["data"] as? [[String : NSObject]] else {
                
                return
            }
            
            self.prettyAnchorGroup.tag_name = "颜值"
            self.prettyAnchorGroup.icon_name = "home_header_normal"
            
            for dict in dictArray {
                
                self.prettyAnchorGroup.anchors.append(WKAnchorModel(dict: dict))
            }
            
            //离开
            disPathGroup.leave()
            
        }
        
        //进入组
        disPathGroup.enter()
        
        //获取2-12组的数据  http://capi.douyucdn.cn/api/v1/getHotCate
        self.loadAnchorData(urlStr: "http://capi.douyucdn.cn/api/v1/getHotCate", parame: parame) {
            
            disPathGroup.leave()
        }
        
        disPathGroup.notify(queue: DispatchQueue.main) {
            
            self.modelArray.insert(self.prettyAnchorGroup, at: 0)
            self.modelArray.insert(self.hotAnchorGroup, at: 0)
            
            finished()
        }
        
    }
    
    func loadCycleData(finished: @escaping () -> ()) {
        
        WKNetworkTools.requestData(url: "http://www.douyutv.com/api/v1/slide/6", type: .get, parame: ["version" : "2.300" as NSObject]) { (resulet) in
            
            guard let resulet = resulet as? [String: NSObject] else {
            
                return
            }
            
            guard let dictArray = resulet["data"] as? [[String : NSObject]] else {
            
                return
            }
            
            //字典转模型
            for dict in dictArray {
            
                self.cycleModel.append(WKCycleModel(dict: dict))
            }
            
            finished()
        }
        
        
    }
    
    
}
