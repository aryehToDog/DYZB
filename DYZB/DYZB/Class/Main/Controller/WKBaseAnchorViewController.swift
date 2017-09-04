//
//  WKBaseAnchorViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/3.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

let kReusableView = "kReusableView"
let kNormalItemCell = "kNormalItemCell"
let kPerttyItemCell = "kPerttyItemCell"

//layout 的头部高度
private let kItemwGroupH: CGFloat = 50

//item间距
private let kItemwMaragin: CGFloat = 10
//item宽度
let kItemwW: CGFloat = (WKWidth - 3 * kItemwMaragin) * 0.5

let kNormalItemH: CGFloat = kItemwW * (3 / 4)
let kPerttyItemH: CGFloat = kItemwW * (4 / 3)

class WKBaseAnchorViewController: WKBaseViewController {
    
    var baseViewModel: WKBaseAnchorViewModel!
    
    //懒加载一个collcectionView
    lazy var collectionView: UICollectionView = {
        
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
        
        // Do any additional setup after loading the view.
        
        setupUI()
        reloadData()
    }
    
}

extension WKBaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

extension WKBaseAnchorViewController {
    
    func reloadData() {
        
        
    }
    
}

extension WKBaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseViewModel.modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let modelGroup = baseViewModel.modelArray[section]
        
        return modelGroup.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalItemCell, for: indexPath)
            as! WKNormalCollectionViewCell
        
        let modelGroup = baseViewModel.modelArray[indexPath.section]
        
        cell.anchorModel = modelGroup.anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableView, for: indexPath) as! WKReusableView
        
        let modelGroup = baseViewModel.modelArray[indexPath.section]
        
        cell.anchorM = modelGroup
        
        return cell
    }
}

