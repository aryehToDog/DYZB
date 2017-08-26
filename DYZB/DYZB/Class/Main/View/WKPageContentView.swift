//
//  WKPageContentView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/26.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

let kCollectionViewIdentifier = "kCollectionViewIdentifier"


class WKPageContentView: UIView {

    //定义数组进行保存
    fileprivate var childsVc = [UIViewController]()
    fileprivate var parentVc = UIViewController()
    
    //懒加载collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        //流水布局
        let layout = UICollectionViewFlowLayout()
        
        //设置间距跟item的大小
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.frame.size
        layout.scrollDirection = .horizontal
    
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.bounces = false
//        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewIdentifier)
        
        return collectionView
    }()
    
    
    init(frame: CGRect, childsVc: [UIViewController], parentVc: UIViewController) {
        
        self.childsVc = childsVc
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        //初始化UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension WKPageContentView {

    fileprivate func setupUI() {
    
        //将子控制器添加到父控制器中
        for vc in self.childsVc {
            
            self.parentVc.addChildViewController(vc)
        }
        
        //添加collectionView
        self.addSubview(collectionView)
        collectionView.frame = self.bounds
    }
}

extension WKPageContentView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return self.childsVc.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewIdentifier, for: indexPath)
        
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        let childVc = self.childsVc[indexPath.item]
        childVc.view .frame = self.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    
}

