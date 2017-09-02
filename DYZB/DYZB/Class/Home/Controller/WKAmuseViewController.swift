//
//  WKAmuseViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

fileprivate let amuseMenuViewH: CGFloat = 200


class WKAmuseViewController: WKBaseAnchorViewController {
    
    let amuseViewModel: WKAmuseViewModel = WKAmuseViewModel()
    
    //懒加载
    fileprivate lazy var amuseMenuView: WKAmuseMenuView = {
        
        let amuseMenuView = WKAmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -amuseMenuViewH, width: WKWidth, height: amuseMenuViewH)
        return amuseMenuView
    }()
    
    
}

extension WKAmuseViewController {
    
    override func setupUI() {
        
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        
        collectionView.contentInset = UIEdgeInsets(top: amuseMenuViewH, left: 0, bottom: 0, right: 0)
    }
    
}

extension WKAmuseViewController {
    
    override func reloadData() {
        
        baseViewModel = amuseViewModel
        
        
        amuseViewModel.loadAmuseData {
            
            var tempGroupModel = self.amuseViewModel.modelArray
            tempGroupModel.remove(at: 0)
            
            self.amuseMenuView.anchorGroupModel = tempGroupModel
            
            self.collectionView.reloadData()
        }
    }
    
}


