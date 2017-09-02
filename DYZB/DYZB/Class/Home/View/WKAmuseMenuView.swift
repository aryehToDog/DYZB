//
//  WKAmuseMenuView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKAmuseMenuView: UIView {
    
    fileprivate let kAmuseMenuViewCellId = "kAmuseMenuViewCellId"
    var anchorGroupModel: [WKAnchorGroup]? {
        
        didSet {
            
            collectionView.reloadData()
        }
        
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        collectionView.register(UINib(nibName: "WKAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuViewCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
}

extension WKAmuseMenuView {
    
    class func amuseMenuView() -> WKAmuseMenuView{
        
        return Bundle.main.loadNibNamed("WKAmuseMenuView", owner: nil, options: nil)?.first as! WKAmuseMenuView
    }
    
}

extension WKAmuseMenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if anchorGroupModel == nil { return 0 }
        
        let pageNumble = (anchorGroupModel!.count - 1) / 8 + 1
        
        pageControl.numberOfPages = pageNumble
        if pageNumble == 0 {
            
            pageControl.currentPageIndicatorTintColor = UIColor.white
        }else {
        
            pageControl.currentPageIndicatorTintColor = UIColor.orange
        }
        
        
        return pageNumble
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuViewCellId, for: indexPath) as! WKAmuseMenuViewCell
        
        //传值给amuseMenuViewCell
        //获取起始位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        cell.anchorGroupModel = Array(anchorGroupModel![startIndex...endIndex])
        
        if endIndex > anchorGroupModel!.count - 1 {
            endIndex = anchorGroupModel!.count - 1
        }
        
        return cell
    }
    
}

extension WKAmuseMenuView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
    }
    
}
