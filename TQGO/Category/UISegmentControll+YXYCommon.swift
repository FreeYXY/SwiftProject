//
//  UISegmentControll+YXYCommon.swift
//  TQGO
//
//  Created by YXY on 2019/10/23.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import UIKit
extension UISegmentedControl {

    public func ensureiOS12Style() {

        if #available(iOS 13, *) {
         
            let tintColorImage = UIColor.white.asImage(CGSize(width:self.frame.width, height:self.frame.height))
            let dividerColorImage = UIColor.white.asImage(CGSize(width:1, height:self.frame.height))
            
            // 设置选中后滑块显示的图片
            setBackgroundImage(tintColorImage, for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .highlighted, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            // 设置分割线样式
            setDividerImage(dividerColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            setDividerImage(dividerColorImage, forLeftSegmentState: .selected, rightSegmentState: .selected, barMetrics: .default)
            
            self.apportionsSegmentWidthsByContent = true
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 0

        }

    }
    
}

