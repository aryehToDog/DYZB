//
//  WKGameViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/1.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

private let kMaragin: CGFloat = 10
private let kItemW: CGFloat = (WKWidth - 2 * kMaragin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
//layout 的头部高度
private let kItemwGroupH: CGFloat = 50
private let kGameViewH : CGFloat = 90
private let gameViewCellID = "gameViewCellID"
//private let kReusableView = "kReusableView"

class WKGameViewController: UIViewController {
    
    //获取gameViewModel
    let gameViewModel: WKGameViewModel = WKGameViewModel()
    
    
    //懒加载一个collectionView
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        
        //设置属性
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMaragin, bottom: 0, right: kMaragin)
        layout.headerReferenceSize = CGSize(width: WKWidth, height: kItemwGroupH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "WKGameViewCell", bundle: nil), forCellWithReuseIdentifier: gameViewCellID)
        
        collectionView.register(UINib(nibName: "WKReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kReusableView)
        
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
        }()
    
    //懒加载headView
    fileprivate lazy var headView:WKReusableView = {
        
        let headView = WKReusableView.reusableView()
        
        headView.frame = CGRect(x: 0, y: -(kGameViewH + kItemwGroupH), width: WKWidth, height: kItemwGroupH)
        headView.nickNameLable.text = "热门"
        headView.iconView.image = UIImage(named: "Img_orange")
        headView.moreBtn.isHidden = true
        return headView
    
    }()
    
    //添加gameView
    fileprivate lazy var gameView: WKRecommendGanmeView = {
    
        let gameView = WKRecommendGanmeView.recommendGanmeView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH , width: WKWidth, height: kGameViewH)
        
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setLoadData()
        
        
    }
    
    
}

extension WKGameViewController {
    
    func setLoadData() {
        
        gameViewModel.loadGameData {
            
            //刷新数据
            self.collectionView.reloadData()
            
            self.gameView.groupModel = Array(self.gameViewModel.gameModelArray[0..<10])
        }
        
    }
}

extension WKGameViewController {
    
    func setupUI() {
        
        view.addSubview(collectionView)
        
        //添加头部
        collectionView.addSubview(headView)
        
        //添加gameView
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kItemwGroupH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}



extension WKGameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gameViewModel.gameModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewCellID, for: indexPath) as! WKGameViewCell
        
        cell.groupM = gameViewModel.gameModelArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableView, for: indexPath) as! WKReusableView
        
        cell.nickNameLable.text = "全部"
        cell.iconView.image = UIImage(named: "Img_orange")
        cell.moreBtn.isHidden = true
        
        return cell
    }
    
}
