//
//  WKPageTitleView.swift
//  DYZB
//
//  Created by 阿拉斯加的狗 on 2017/8/26.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    
    func pageTitleViewDidClickTitleLableIndex(pageTitleView: WKPageTitleView, selectIndex: Int)
    
}

//定义变量
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class WKPageTitleView: UIView {
    
    //定义代理
    weak var delegate: PageTitleViewDelegate?
    
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
    
    //自定义当前index
    var currentIndex: Int = 0
    
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
            titleLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            titleLable.textAlignment = .center
            titleLable.text = title
            titleLable.tag = index
            
            scrollView.addSubview(titleLable)
            
            //添加到lable数组中
            self.titleLables.append(titleLable)
            
            titleLable.isUserInteractionEnabled = true
            //给lable添加手势
            let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickIndexLable))
            
            titleLable.addGestureRecognizer(tapGest)
        }
        
    }
    
    fileprivate func setupBottomLineAddIndicator() {
        
        self.addSubview(bottomLine)
        bottomLine.frame = CGRect(x: 0, y: self.bounds.size.height, width: self.bounds.size.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray
        
        scrollView.addSubview(indicatorView)
        let titleLbale = self.titleLables.first
        titleLbale?.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        indicatorView.frame = CGRect(x: 0, y: 38, width: (titleLbale?.frame.size.width)!, height: 2)
        indicatorView.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    }
    
}


// MARK: - 点击事件处理
extension WKPageTitleView {
    
    @objc fileprivate func clickIndexLable(tap: UITapGestureRecognizer) {
        
        print("-------clickIndexLable-----")
        //1.改变lable的文字颜色
        guard let currentLable = tap.view as? UILabel else {
            return
        }
        
        //判断如果是每次点击同一个item直接返回
        if tap.view?.tag == currentIndex {
            
            return
        }
        
        //获取到以前的lable
        let oldLable = self.titleLables[currentIndex]
        
        
        //获取现在的lable的index
        currentLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = (tap.view?.tag)!
        
        //设置指示器的滑动
        let indicatorViewX = CGFloat(currentIndex) * self.indicatorView.frame.width
        
        UIView.animate(withDuration: 0.25) {
            
            self.indicatorView.frame.origin.x = indicatorViewX
        }
        
        //通知代理将点击的index传出去
        self.delegate?.pageTitleViewDidClickTitleLableIndex(pageTitleView: self, selectIndex: currentIndex)
        
    }
    
}


// MARK: - 暴露在外部的方法
extension WKPageTitleView {
    
    func pageTitleViewContentIndexView(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        let sourceLable = self.titleLables[sourceIndex]
        let targetLable = self.titleLables[targetIndex]
        
        //控制指示器的滑动
        let moveContentOffestX = targetLable.frame.origin.x - sourceLable.frame.origin.x
        self.indicatorView.frame.origin.x = sourceLable.frame.origin.x + moveContentOffestX * progress
        
        //设置渐变的颜色
        let colorData = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.1 - kNormalColor.1)
        
        sourceLable.textColor = UIColor(r: kSelectColor.0 - colorData.0 * progress, g: kSelectColor.1 - colorData.1 * progress, b: kSelectColor.2 - colorData.2 * progress)
        
        targetLable.textColor = UIColor(r: kNormalColor.0 + colorData.0 * progress, g: kNormalColor.1 + colorData.1 * progress, b: kNormalColor.2 + colorData.2 * progress)
        
        currentIndex = targetIndex
    }
    
}
