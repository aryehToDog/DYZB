//
//  WKRecommendController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/28.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

private let kCycleViewH: CGFloat = WKWidth * 3 / 8

private let kGameViewH: CGFloat = 90

class WKRecommendController: WKBaseAnchorViewController {
    
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
    
}

// MARK: - 设置UI
extension WKRecommendController {
    
    override func setupUI() {
        
        super.setupUI()
        
        //添加cycleView
        collectionView.addSubview(cycleView)
        
        //添加gameView
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

extension WKRecommendController {
    
    override func reloadData() {
        
        self.baseViewModel = self.recommerndVM
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

extension WKRecommendController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyItemCell, for: indexPath) as! WKPrettyCollectionViewCell
            let modelGroup = recommerndVM.modelArray[indexPath.section]
            
            cell.anchorModel = modelGroup.anchors[indexPath.item]
            
            return cell
            
        } else {
               
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            
            return CGSize(width: kItemwW, height: kPerttyItemH)
        }else {
            
            return CGSize(width: kItemwW, height: kNormalItemH)
        }
    }
    
}



