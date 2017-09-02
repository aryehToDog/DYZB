//
//  WKAmuseViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit



class WKAmuseViewController: WKBaseAnchorViewController {
    
    let amuseViewModel: WKAmuseViewModel = WKAmuseViewModel()
    
}



extension WKAmuseViewController {

    override func reloadData() {
    
        baseViewModel = amuseViewModel
        
        amuseViewModel.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
    
}


