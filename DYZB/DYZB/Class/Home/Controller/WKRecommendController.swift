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

class WKRecommendController: UIViewController {
    
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
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}


// MARK: - 设置UI
extension WKRecommendController {
    
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        
    }
    
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension WKRecommendController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 1 {
            return 8
        }else {
        
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyItemCell, for: indexPath)

            return cell
        } else {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalItemCell, for: indexPath)
            
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableView, for: indexPath)
        
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

