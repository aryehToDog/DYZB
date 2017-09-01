//
//  WKRecommendGanmeView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/31.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

private let kGanmeViewCellID = "kGanmeViewCellID"


class WKRecommendGanmeView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var gameModel: [WKGameModel]? {
//        
//        didSet {
//            
//            collectionView.reloadData()
//            
//        }
//        
//    }
    
    
     var groupModel: [WKBaseGameModel]? {
    
        didSet {
        
            //刷新数据
            collectionView.reloadData()

        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()

        
        //注册cell
        collectionView.register(UINib(nibName: "WKGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGanmeViewCellID)
        
        //设置属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 80, height: 90)
        layout.scrollDirection = .horizontal
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
    }

    
    class func recommendGanmeView() -> WKRecommendGanmeView {
        
        return (Bundle.main.loadNibNamed( "WKRecommendGanmeView", owner: nil, options: nil)?.first as? WKRecommendGanmeView)!
    }
}

extension WKRecommendGanmeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.groupModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGanmeViewCellID, for: indexPath) as! WKGameViewCell
        
        cell.groupM = self.groupModel?[indexPath.item]
        
        return cell
    }
    
}
