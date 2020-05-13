//
//  UITextField+YYCommon.swift
//  TQGO
//
//  Created by YXY on 2019/10/23.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    
    func leftViewWithImgName(imgName:String , size:CGSize){
       
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.frame.height))
        let y  = (self.frame.height - size.height)/2;
        let imgV = UIImageView(frame: CGRect(x: 0, y: y, width: size.width, height: size.height))
        containerView.addSubview(imgV)
        self.leftViewMode = UITextField.ViewMode.always
        imgV.contentMode = UIView.ContentMode.left;
        imgV.image = kImage(name: imgName)
        self.leftView = containerView
        
    }
}
