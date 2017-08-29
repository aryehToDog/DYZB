//
//  WKNetworkTools.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/29.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class WKNetworkTools: NSObject {

    class func requestData(url: String, type:MethodType, parame: [String: NSObject]?, finished: @escaping (_ result: Any) -> ()) {
    
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: parame).responseJSON { (response) in
            
            
            guard let result = response.result.value else {
            
                print(response.error)
                return
            }
            
            finished(result)
            
        }
    }
}
