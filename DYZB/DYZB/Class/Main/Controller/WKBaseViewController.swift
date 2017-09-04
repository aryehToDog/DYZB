//
//  WKBaseViewController.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/9/4.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKBaseViewController: UIViewController {

    var contentView: UIView!
    
    
    //懒加载一个uiimageview
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

            setupUI()

    }
}

extension WKBaseViewController {

    func setupUI() {
    
        contentView.isHidden = true
        
        view.backgroundColor = UIColor.white
        imageView.startAnimating()
        view.addSubview(imageView)
        
        
    }
}

extension WKBaseViewController {

    func finishedCallBackEndAnimatin() {
        
        imageView.stopAnimating()
        contentView.isHidden = false
        
        imageView.isHidden = true
    }

}
