//
//  UIView+Common.swift
//  TQGO
//
//  Created by YXY on 2018/7/11.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import UIKit

//MARK: Frame
extension UIView {
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    /// 右边界的x值
    public var rightX: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.width
            self.frame = r
        }
    }
    /// 下边界的y值
    public var bottomY: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.height
            self.frame = r
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var height: CGFloat{
        get{
            return self.frame.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
}

extension UIView{
    /// 获取视图根控制器
    func viewController() -> UIViewController? {
        var next: UIResponder?  = self.next
        
        repeat {
            if (next?.isKind(of: UIViewController.self) == true) {
                return next as? UIViewController
            }
            next = next?.next
        }while (next != nil)
        return nil
    }
//    extension UIView {
//        //返回该view所在VC
//        func firstViewController() -> UIViewController? {
//            for view in sequence(first: self.superview, next: { $0?.superview }) {
//                if let responder = view?.next {
//                    if responder.isKind(of: UIViewController.self){
//                        return responder as? UIViewController
//                    }
//                }
//            }
//            return nil
//        }
//    }
    
    /// 截图
    func snapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap!
    }
    
    
    /// 可设置指定位置圆角
    /// - Parameter corners: 圆角位置
    /// - Parameter radius: 角度
    func cornerRadius(corners: UIRectCorner = .allCorners , radius: CGFloat) {
        layoutIfNeeded()
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
