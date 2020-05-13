//
//  UIColor+YXYCommon.swift
//  TQGO
//
//  Created by YXY on 2019/10/23.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {

    public func asImage(_ size:CGSize) -> UIImage? {

        var resultImage:UIImage? = nil

        let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return resultImage
        }

        context.setFillColor(self.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
        
    }

}


