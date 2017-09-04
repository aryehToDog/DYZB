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
        
        //panGest view  action 跟 selection
        guard let panGest = self.interactivePopGestureRecognizer else {
            return
        }
        
        guard let gestView = panGest.view else {
            return
        }
        
        //利用运行时获取私有属性
//        var count: UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
//        
//        for i in 0..<count {
//            let ivar = ivars?[Int(i)]
//            
//            _ = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        
        //_targets 获取私有属性
         let targets = panGest.value(forKey: "_targets") as? [NSObject]
        
//        print(targets)
        
        guard let targetsObj = targets?.first else {
        
            return
        }
        
        
//        (
//            "(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f807fd10550>)"
//        )
        
        //获取action 跟 target
        guard let target = targetsObj.value(forKey: "target") else {
        
            return
        }
        
        //获取sel
        let action = Selector(("handleNavigationTransition:"))
        
        
        //创建新的手势
        let newPanGest = UIPanGestureRecognizer()
        
        gestView.addGestureRecognizer(newPanGest)
        newPanGest.addTarget(target, action: action)
        
    }
    
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: true)
    }
    
}
