//
//  UIButton+YXYCommon.swift
//  TQGO
//  UIButton通用分类
//  Created by YXY on 2019/10/22.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation



enum YXYButtonEdgeInsetsStyle {
    case  YXYButtonEdgeInsetsStyleTop // image在上，label在下
    case  YXYButtonEdgeInsetsStyleLeft // image在左，label在右
    case  YXYButtonEdgeInsetsStyleBottom // image在下，label在上
    case  YXYButtonEdgeInsetsStyleRight // image在右，label在左
}
//MARK: title image 位置布局
extension UIButton{
    
    /// 调整文字和图片相对位置
    /// - Parameter style: 显示样式
    /// - Parameter imageTitleSpace: 间距
    func layoutButtonWithEdgeInsetsStyle(style:YXYButtonEdgeInsetsStyle,imageTitleSpace:CGFloat) {
        let imageWith:CGFloat =  imageView?.frame.width ?? 0;
        let imageHeight:CGFloat = imageView?.frame.height ?? 0;
        
        var labelWidth:CGFloat = 0.0;
        var labelHeight:CGFloat = 0.0;
        
        if (kSystemVersion >= 8.0) {
            // 由于iOS8中titleLabel的size为0，用下面的这种设置
            labelWidth = titleLabel?.intrinsicContentSize.width ?? 0;
            labelHeight = titleLabel?.intrinsicContentSize.height ?? 0;
        } else {
            labelWidth = titleLabel?.frame.width ?? 0;
            labelHeight = titleLabel?.frame.height ?? 0;
        }
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets  = UIEdgeInsets.zero;
        var labelEdgeInsets: UIEdgeInsets  = UIEdgeInsets.zero;
        
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .YXYButtonEdgeInsetsStyleTop:
            imageEdgeInsets =  UIEdgeInsets(top: -labelHeight-imageTitleSpace/2.0, left: 0, bottom: 0, right:  -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left:  -imageWith, bottom:  -imageHeight-imageTitleSpace/2.0, right: 0)
        case .YXYButtonEdgeInsetsStyleLeft:
            imageEdgeInsets = UIEdgeInsets(top:0, left:-imageTitleSpace/2.0, bottom:0, right: imageTitleSpace/2.0);
            labelEdgeInsets = UIEdgeInsets(top:0,left: imageTitleSpace/2.0, bottom:0, right: -imageTitleSpace/2.0);
        case .YXYButtonEdgeInsetsStyleBottom:
            imageEdgeInsets = UIEdgeInsets(top:0, left:0, bottom:-labelHeight-imageTitleSpace/2.0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top:-imageHeight-imageTitleSpace/2.0,left: -imageWith, bottom:0, right: 0);
        case .YXYButtonEdgeInsetsStyleRight:
            imageEdgeInsets = UIEdgeInsets(top:0,left: labelWidth+imageTitleSpace/2.0, bottom:0, right: -labelWidth-imageTitleSpace/2.0);
            labelEdgeInsets = UIEdgeInsets(top:0, left:-imageWith-imageTitleSpace/2.0, bottom:0, right: imageWith+imageTitleSpace/2.0);
        }
        
        // 4. 赋值
        titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
    
}

