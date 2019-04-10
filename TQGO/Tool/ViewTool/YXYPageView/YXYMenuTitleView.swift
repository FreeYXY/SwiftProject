
//
//  YXYMenuTitleView.swift
//  TQGO
//
//  Created by YXY on 2019/3/21.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import UIKit

protocol YXYMenuMoveProtocol:class {
    func  menuMoveProtocol(formIndex:NSInteger,toIndex:NSInteger)
}


enum YXYIndicatorType:NSInteger {
    case YXYIndicatorTypeDefault = 0,//默认与按钮长度相同
    YXYIndicatorTypeEqualTitle,//与文字长度相同
    YXYIndicatorTypeCustom,//自定义文字边缘延伸宽度
    YXYIndicatorTypeNone
}//指示器类型枚举

class YXYMenuTitleView: UIView {
    
    var indicatorType:YXYIndicatorType = .YXYIndicatorTypeDefault{
        didSet{
            moveIndicatorView()
        }
    }
    var titleArr: Array = [String]()
    var menuArr :Array = [UIButton]()
    var menuWidth:CGFloat = 60.0
    var selectIndex:NSInteger = 0{
        didSet{
            moveIndicatorView()
        }
    }
    var indicatorHeight:CGFloat = 2
    var indicatorExtension:CGFloat = 0 {
        didSet{
            moveIndicatorView()
        }
    }
    
    weak var menuMoveDelegate:YXYMenuMoveProtocol?
    // 按钮间距离
    var menuMargin:CGFloat = 20{
        didSet{
            
        }
    }
    // 字体大小
    var menuFont:CGFloat = 14{
        didSet{
            
        }
    }
    
    lazy var menuScrollView: UIScrollView = {
        let menuScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        menuScrollView.contentSize = CGSize(width: (menuScrollCount*menuWidth), height: self.height)
        return menuScrollView
    }()
    
    lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = KCOLOR_Base.font_blue
        menuScrollView.addSubview(indicatorView)
        return indicatorView
    }()
    
   
  
    var menuScrollCount:CGFloat = 5 {
        didSet{
            menuScrollView.contentSize = CGSize(width: menuScrollCount*menuWidth, height: self.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect,titleArr:[String]) {
        self.init(frame:frame)
        self.backgroundColor = .white
        self.addSubview(self.menuScrollView)
        self.setupMenu(titleArr: titleArr)
        
        let line = UIView()
        line.backgroundColor = KCOLOR_Base.line
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moveIndicatorView()
    }
    
    func moveIndicatorView(){
        if menuArr.isEmpty {
            return
        }
        let selectedBtn = menuArr[selectIndex]
        let indicatorWidth:CGFloat = (selectedBtn.titleLabel?.text?.width(fontSize: menuFont))!
            
        UIView.animate(withDuration: 0.05, animations: {
            switch self.indicatorType {
            case .YXYIndicatorTypeDefault:
                self.indicatorView.frame = CGRect(x: selectedBtn.x, y: selectedBtn.bottomY-self.indicatorHeight, width: selectedBtn.width, height: self.indicatorHeight)
                break
            case .YXYIndicatorTypeEqualTitle:
                self.indicatorView.center = CGPoint(x: selectedBtn.centerX, y: selectedBtn.bottomY-self.indicatorHeight/2)
                self.indicatorView.bounds = CGRect(x: 0, y: 0,width:indicatorWidth , height: self.indicatorHeight)
                break
            case .YXYIndicatorTypeCustom:
                self.indicatorView.center = CGPoint(x: selectedBtn.centerX, y: selectedBtn.bottomY-self.indicatorHeight/2)
                self.indicatorView.bounds = CGRect(x: 0, y: 0,width:self.indicatorExtension , height: self.indicatorHeight)
                break
            case .YXYIndicatorTypeNone:
                self.indicatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 0);
                break
            }
        }) { (finished) in
            
        }
    }
    
    func setupMenu(titleArr:[String]) {
        let _ = menuArr.map { (make) -> Void in
            make.removeFromSuperview()
        }
        menuArr.removeAll()
        if titleArr.isEmpty {
            return
        }
        var totalMenuWidth:CGFloat = 0
        for (_, val) in titleArr.enumerated() {
            let menuWidth = val.width(fontSize: menuFont) + menuMargin
            let menu = UIButton(type: UIButtonType.custom)
            menu.frame = CGRect(x: totalMenuWidth, y: 0.0, width: menuWidth, height: self.height)
            menu.setTitle(val, for: UIControlState.normal)
            menu.setTitleColor(.black, for: .normal)
            menu.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            menu.addTarget(self, action: #selector(menuAction), for: UIControlEvents.touchUpInside)
            menuScrollView.addSubview(menu)
            menuArr.append(menu)
            totalMenuWidth = totalMenuWidth + menuWidth
            
           
        }
    }
    
    @objc func menuAction(sender:UIButton){
        let index = menuArr.firstIndex(of: sender)
        if selectIndex == index {
            return
        }
        if menuMoveDelegate != nil{
            menuMoveDelegate?.menuMoveProtocol(formIndex: selectIndex, toIndex: index!)
        }
        selectIndex = index!
        moveIndicatorView()
    }
}
