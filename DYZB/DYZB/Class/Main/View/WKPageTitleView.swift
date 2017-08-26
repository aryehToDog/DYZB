//
//  WKPageTitleView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/26.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

class WKPageTitleView: UIView {
    
    //保存数组
    fileprivate var titles = [String]()
    
    //懒加载
    fileprivate lazy var scrollView: UIScrollView = {
        
        var scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        
        return scrollView
    }()
    
    //存放lable的数组
    fileprivate lazy var titleLables = [UILabel]()
    
    //底部的线
    fileprivate lazy var bottomLine: UIView = UIView()
    
    //指示器的线
    fileprivate lazy var indicatorView: UIView = UIView()
    
    //自定义函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WKPageTitleView {
    
    fileprivate func setUpUI() {
        
        //1.添加scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加lable
        setupTitleLbale()
        
        //3.添加指示器跟底部线
        setupBottomLineAddIndicator()
        
    }
    
    fileprivate func setupTitleLbale() {
        
        let lableH: CGFloat = 38
        let lableW: CGFloat = WKWidth / CGFloat(self.titles.count)
        let lableY: CGFloat = 0
        
        //index 获取tag值, title 获取文字数组的文字
        for (index, title) in titles.enumerated() {
            
            let titleLable = UILabel()
            
            let lableX: CGFloat = CGFloat(index) * lableW
            titleLable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            titleLable.font = UIFont.systemFont(ofSize: 16.0)
            titleLable.textColor = UIColor.darkGray
            titleLable.textAlignment = .center
            titleLable.text = title
            titleLable.tag = index
            
            scrollView.addSubview(titleLable)
            
            //添加到lable数组中
            self.titleLables.append(titleLable)
        }
        
    }
    
    fileprivate func setupBottomLineAddIndicator() {
        
        self.addSubview(bottomLine)
        bottomLine.frame = CGRect(x: 0, y: self.bounds.size.height, width: self.bounds.size.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray
        
        scrollView.addSubview(indicatorView)
        let titleLbale = self.titleLables.first
        indicatorView.frame = CGRect(x: 0, y: 38, width: (titleLbale?.frame.size.width)!, height: 2)
        indicatorView.backgroundColor = UIColor.orange
    }
    
}
