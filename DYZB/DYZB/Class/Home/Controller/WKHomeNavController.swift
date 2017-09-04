//
//  WKHomeNavController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/4.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKHomeNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: true)
    }

}
