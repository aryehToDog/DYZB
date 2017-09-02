//
//  WKAmuseMenuViewCell.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

fileprivate let kGameViewCellId = "kGameViewCellId"
class WKAmuseMenuViewCell: UICollectionViewCell {
    
    var anchorGroupModel: [WKAnchorGroup]? {
        
        didSet {
            
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "WKGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemW:CGFloat = self.frame.size.width / 4
        let itemH:CGFloat = self.frame.size.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.dataSource = self
    }
}

extension WKAmuseMenuViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        let modelGroup = anchorGroupModel[section]
        
        return self.anchorGroupModel!.count 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellId, for: indexPath) as! WKGameViewCell
        
        cell.groupM = self.anchorGroupModel?[indexPath.item]
        
        cell.clipsToBounds = true
        
        return cell
    }
}
