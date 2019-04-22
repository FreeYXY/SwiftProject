//
//  String+Common.swift
//  TQGO
//
//  Created by YXY on 2018/7/11.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    var md5 : String{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
//        result.deinitialize()
        result.deinitialize(count: 1)
        return String(format: hash as String)
    }
    
   static func nowTimeWithFormat(format:String) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: kDate_Location)
        return  dateFormatter.string(from: Date())
    }
    
    /// 获取一段字符串的宽度
    ///
    /// - Parameter fontSize: 字体大小
    /// - Returns: 字符串宽度
    func width(fontSize:CGFloat) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)]).width
    }

    /// 判断文件是否存在
    ///
    /// - Returns: 存在true 不存在false
    func fileExist() -> Bool {
        return FileManager.default.fileExists(atPath: self as String)
    }
    
    /// 创建文件夹
    func fileCreateDirectory() {
        try! FileManager.default.createDirectory(at: NSURL(fileURLWithPath:self , isDirectory: true, relativeTo: nil) as URL, withIntermediateDirectories: true, attributes: nil)
    }
    
    /// 拼接路径
    ///
    /// - Parameter byAppendingPaths: 要拼接的文件名
    /// - Returns: 拼接后的路径
    func fileByAppendingPaths(byAppendingPaths: String) -> String {
        return (self as NSString).strings(byAppendingPaths: [byAppendingPaths]).first!
    }
   
}
