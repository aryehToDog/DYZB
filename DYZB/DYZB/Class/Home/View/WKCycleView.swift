//
//  WKCycleView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/30.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

fileprivate let kCollectionViewId = "kCollectionViewId"

class WKCycleView: UIView {
    
    var time :Timer?
    
    
    //定义模型属性
    var cycleModel: [WKCycleModel]? {
        
        //进行数据刷新
        didSet {
            
            collectionView.reloadData()
            pageView.numberOfPages = self.cycleModel?.count ?? 0
            
            //设置滚动的位置
            let indexPath = IndexPath(item: (cycleModel?.count)! * 10, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //移除再添加
            dissTime()
            
            addTime()
        }
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    override func awakeFromNib() {
        
        self.autoresizingMask = UIViewAutoresizing()
        
    }
    
    //设置frame
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置基本属性
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: "WKCycleCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewId)
    }
    
    //创建自定义view类方法
    class func cycleView() -> WKCycleView {
        
        return (Bundle.main.loadNibNamed("WKCycleView", owner: nil, options: nil)?.last as? WKCycleView)!
    }
}


// MARK: - UICollectionViewDataSource
extension WKCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cycleModel?.count ?? 0) * 10000
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewId, for: indexPath) as! WKCycleCell
        
        cell.cycleModel = self.cycleModel?[indexPath.item % (self.cycleModel?.count)!]
        
        return cell
        
    }
}


// MARK: - UICollectionViewDelegate
extension WKCycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffest = scrollView.contentOffset.x + (scrollView.frame.size.width * 0.5)
        
        pageView.currentPage = Int(contentOffest / self.frame.size.width) % (self.cycleModel?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        dissTime()
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        addTime()
        
    }
    
}

extension WKCycleView {
    
    func addTime() {
        
        let timer = Timer(timeInterval: 3.0, target: self, selector: #selector(timeWithScorlToCycleView), userInfo: nil, repeats: true)
        self.time = timer
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    
    }
    
    
    func dissTime() {
    
        self.time?.invalidate()
        self.time = nil
    }
    
    
    
    @objc func timeWithScorlToCycleView() {
        
        //滚动到相应位置
        let contentOffest:CGFloat = collectionView.contentOffset.x
        
        collectionView.setContentOffset(CGPoint(x: contentOffest + self.frame.size.width, y: 0), animated: true)
    }
    
}



