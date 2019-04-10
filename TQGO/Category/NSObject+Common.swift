//
//  NSObject+Common.swift
//  TQGO
//
//  Created by YXY on 2018/7/20.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import UIKit

extension NSObject{
    
    /// 模型转JSONString
    var modelToJSONString : String {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        let jsonStr = String(data: jsonData!, encoding: String.Encoding.utf8)
        return jsonStr!
    }
}
