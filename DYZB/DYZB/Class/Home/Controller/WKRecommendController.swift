//
//  WKRecommendController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/28.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

private let kReusableView = "kReusableView"
private let kNormalItemCell = "kNormalItemCell"
private let kPerttyItemCell = "kPerttyItemCell"

//layout 的头部高度
private let kItemwGroupH: CGFloat = 50

//item间距
private let kItemwMaragin: CGFloat = 10
//item宽度
private let kItemwW: CGFloat = (WKWidth - 3 * kItemwMaragin) * 0.5

private let kNormalItemH: CGFloat = kItemwW * (3 / 4)
private let kPerttyItemH: CGFloat = kItemwW * (4 / 3)

private let kCycleViewH: CGFloat = WKWidth * 3 / 8

private let kGameViewH: CGFloat = 90

class WKRecommendController: UIViewController {
    
    fileprivate lazy var recommerndVM = WKRecommendViewModel()
    
    fileprivate lazy var cycleView: WKCycleView = {
        
        let cycleView = WKCycleView.cycleView()
        
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: WKWidth, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView: WKRecommendGanmeView = {
        
        let gameView = WKRecommendGanmeView.recommendGanmeView()
        
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: WKWidth, height: kGameViewH)
        return gameView
    }()
    
    //懒加载一个collection
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        //设置基本属性
        layout.itemSize = CGSize(width: kItemwW, height: kNormalItemH)
        layout.headerReferenceSize = CGSize(width: WKWidth, height: kItemwGroupH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemwMaragin
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        //设置layout 的头部
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        //让view 自动跟随父控件进行宽跟高拉伸
        collectionView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        
        collectionView.register(UINib(nibName: "WKReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kReusableView)
        
        collectionView.register(UINib(nibName: "WKNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalItemCell)
        
        collectionView.register(UINib(nibName: "WKPrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPerttyItemCell)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        //发送请求 更新数据
        recommerndVM.loadData {
            self.collectionView.reloadData()
            
            var anchorGroup = self.recommerndVM.modelArray
            anchorGroup.removeFirst()
            anchorGroup.removeFirst()
            
            let groupLastM = WKAnchorGroup()
            groupLastM.tag_name = "更多"
            groupLastM.icon_url = "home_more_btn"
            anchorGroup.append(groupLastM)
            
            self.gameView.groupModel = anchorGroup
        }
        
        recommerndVM.loadCycleData {
            
            //发送网络请求
            self.cycleView.cycleModel = self.recommerndVM.cycleModel
        }
    }
}

// MARK: - 设置UI
extension WKRecommendController {
    
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        
        //添加cycleView
        collectionView.addSubview(cycleView)
        
        //添加gameView
        collectionView.addSubview(gameView)
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension WKRecommendController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommerndVM.modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let modelGroup = recommerndVM.modelArray[section]
        
        return modelGroup.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WKBaseCollectionViewCell
        
        
        if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyItemCell, for: indexPath) as! WKPrettyCollectionViewCell
            
            
        } else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalItemCell, for: indexPath)
                as! WKNormalCollectionViewCell
            
        }
        let modelGroup = recommerndVM.modelArray[indexPath.section]
        
        cell.anchorModel = modelGroup.anchors[indexPath.item]
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableView, for: indexPath) as! WKReusableView
        
        let modelGroup = recommerndVM.modelArray[indexPath.section]
        
        cell.anchorM = modelGroup
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            
            return CGSize(width: kItemwW, height: kPerttyItemH)
        }else {
            
            return CGSize(width: kItemwW, height: kNormalItemH)
        }
    }
}

