//
//  WKTabBarController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/25.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    
}


extension WKTabBarController {
    
    func setupUI()  {
        
        tabBar.tintColor = UIColor.orange
        
        //添加子控制器
        addChildVC(nameVc: "Home")
        addChildVC(nameVc: "Live")
        addChildVC(nameVc: "Follow")
        addChildVC(nameVc: "Profile")
    }
    
    func addChildVC(nameVc: String)  {
        
        let VC = UIStoryboard(name: nameVc, bundle: nil).instantiateInitialViewController()!
        
        self.addChildViewController(VC)
    }
    
}
