//
//  WKFunnyViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/4.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKFunnyViewController: WKBaseAnchorViewController {

    fileprivate var funnyViewModel:WKFunnyViewModel = WKFunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        
    }

}


extension WKFunnyViewController {
    
    override func setupUI() {
        
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
}

extension WKFunnyViewController {

    override func reloadData() {
        
        baseViewModel = funnyViewModel
        
        funnyViewModel.loadFunnyData {
            self.collectionView.reloadData()
            
            self.finishedCallBackEndAnimatin()
        }
        
    }

}
