//
//  WKPageContentView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/26.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

let kCollectionViewIdentifier = "kCollectionViewIdentifier"


protocol PageContentViewDelegate: class {
    
    func pageContentViewDidScrollviewToContentTitleLable(pageContentView: WKPageContentView, progress: CGFloat,sourceIndex: Int, targetIndex: Int)
}

class WKPageContentView: UIView {
    
    //定义数组进行保存
    fileprivate var childsVc = [UIViewController]()
    fileprivate var parentVc = UIViewController()
    
    //定义禁止scrollView的代理方法判断
    var isForbidScrollDelegate: Bool = false
    
    
    //记录collectionView刚刚滚动的contentOffest的距离
    var startContentOffest: CGFloat = 0
    
    //定义代理
    weak var delegate: PageContentViewDelegate?
    
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
        collectionView.delegate = self
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


extension WKPageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.isForbidScrollDelegate = false
        
        startContentOffest = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果isForbidScrollDelegate为true 直接执行screollView的代理方法
        if self.isForbidScrollDelegate {
            return
        }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let contentW = scrollView.bounds.size.width
        let contentOffsetX = scrollView.contentOffset.x
        
        //判断使用的是左滑还是右滑
        //左滑
        if contentOffsetX > startContentOffest {
            
            progress = contentOffsetX / contentW - floor(contentOffsetX / contentW)
            
            sourceIndex = Int(contentOffsetX / contentW)
            
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childsVc.count {
                targetIndex = childsVc.count - 1
            }
            
            if contentOffsetX - startContentOffest == contentW {
                progress = 1
                targetIndex = sourceIndex
            }
        //右滑
        }else {
            
            progress = 1 - (contentOffsetX / contentW - floor(contentOffsetX / contentW))
            
            targetIndex = Int(contentOffsetX / contentW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childsVc.count {
                sourceIndex = childsVc.count - 1
            }
            
        }
        
        //调用代理方法
        self.delegate?.pageContentViewDidScrollviewToContentTitleLable(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - UICollectionViewDataSource
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



// MARK: - 暴露在外界的方法 - 点击titleLable collectionView view 会进行滚动到相应位置
extension WKPageContentView {
    
    func didClickIndexToCollectionViewCell(index: Int)  {
        
        self.isForbidScrollDelegate = true
        
        //根据contentOffest进行改变
        let contentOffest = self.collectionView.frame.width * CGFloat(index)
        
        self.collectionView.setContentOffset(CGPoint(x: contentOffest, y: 0), animated: true)
    }
    
    
}
