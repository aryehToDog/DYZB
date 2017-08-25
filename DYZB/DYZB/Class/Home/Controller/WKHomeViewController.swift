//
//  WKHomeViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/25.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
        
    }
    
}


// MARK: - 设置UI
extension WKHomeViewController {
    
    fileprivate func setupUI() {
        
        //设置状态栏
        setupNavBar()
    }
    
    func setupNavBar() {
        
        //设置左边itemlogo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageNmae: "logo",target: self, action: #selector(didClickLogo))
        
        let size = CGSize(width: 40, height: 40)
        
        //设置右边的item
        let clockItem = UIBarButtonItem(imageNmae: "image_my_history", highImageName: "Image_my_history_click", size: size, target: self, action: #selector(didClickClockItem))
        let searchItem = UIBarButtonItem(imageNmae: "btn_search", highImageName: "btn_search_clicked", size: size,target: self, action: #selector(didClicksearchItem))
        let cqcoderItem = UIBarButtonItem(imageNmae: "Image_scan", highImageName: "Image_scan_click", size: size,target: self, action: #selector(didClickCqcoderItem))
        
        navigationItem.rightBarButtonItems = [clockItem,searchItem,cqcoderItem]
        
    }
    
}


// MARK: - 状态栏按钮点击方法
extension WKHomeViewController {
    
    @objc func didClickLogo() {
        
        print("didClickLogo")
    }
    
    @objc func didClickClockItem() {
        
        print("didClickClockItem")
    }
    
    @objc func didClicksearchItem() {
        
        print("didClicksearchItem")
    }
    
    @objc func didClickCqcoderItem() {
        
        print("didClickCqcoderItem")
    }
    
}
