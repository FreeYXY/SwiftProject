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
    
}

//MARK: 字符串截取
extension String{
    /// 从某个位置开始截取：
    /// - Parameter index: 起始位置
    public func substring(from index: Int) -> String {
        if(self.count > index){
            let startIndex = self.index(self.startIndex,offsetBy: index)
            let subString = self[startIndex..<self.endIndex];
            return String(subString);
        }else{
            return ""
        }
    }
    
    /// 从零开始截取到某个位置：
    /// - Parameter index: 达到某个位置
    public func substring(to index: Int) -> String {
        if(self.count > index){
            let endindex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<endindex]
            return String(subString)
        }else{
            return self
        }
    }
    
    /// 某个范围内截取
    /// - Parameter rangs: 范围
    public func subString(rang rangs:NSRange) -> String{
        var string = String()
        if(rangs.location >= 0) && (count > (rangs.location + rangs.length)){
            let startIndex = self.index(self.startIndex,offsetBy: rangs.location)
            let endIndex = self.index(self.startIndex,offsetBy: (rangs.location + rangs.length))
            let subString = self[startIndex..<endIndex]
            string = String(subString)
        }
        return string
    }
}

//MARK: 正则校验
extension String{
    /// 根据正则校验
    /// - Parameter regex: 正则表达式
    func isValidateByRegex(regex:String)  ->  Bool {
        let pre :NSPredicate =  NSPredicate(format:  "SELF MATCHES %@", argumentArray: [regex])
        return pre.evaluate(with: self)
    }
    
    /// 手机号分服务商
    func isMobileNumberClassification() ->Bool{
        /**
         15      * 手机号码
         16      * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
         17      * 联通：130,131,132,152,155,156,185,186,1709
         18      * 电信：133,1349,153,180,189,1700
         19      */
        //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
        /**
         23      10         * 中国移动：China Mobile
         24      11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
         25      12         */
        let CM = "^((13[4-9])|(147)|(15[0-2,7-9])|(17[2,8])|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        //    NSString *CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[278])\\d|705)\\d{7}$";
        /**
         28      15         * 中国联通：China Unicom
         29      16         * 130,131,132,152,155,156,185,186,1709
         30      17         */
        let CU = "^((13[0-2])|(145)|(15[5-6])|(17[1,5,6])|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //    NSString *CU = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
        /**
         33      20         * 中国电信：China Telecom
         34      21         * 133,1349,153,180,189,1700
         35      22         */
        let CT = "^((133)|(149)|(153)|(17[3,7])|(18[0,1,9]))\\d{8}$";
        //    NSString *CT = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        //    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
        /**
         40      25         * 大陆地区固话及小灵通
         41      26         * 区号：010,020,021,022,023,024,025,027,028,029
         42      27         * 号码：七位或八位
         43      28         */
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        
        if ( isValidateByRegex(regex: CM) || isValidateByRegex(regex:CU) || isValidateByRegex(regex:CT) || isValidateByRegex(regex:PHS)){
            return true
        }else {
            return false
        }
    }
}

//MARK: file
extension String{
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
    
    /// 读取本地数据
    func getLocalPlistData() -> NSArray? {
        let path = Bundle.main.path(forResource: self, ofType: "plist")
        return NSArray(contentsOfFile: path!)
    }
}

////MARK: 实现NSRange与Range的相互转换
//extension String {
//
//    //Range转换为NSRange
//    func nsRange(from range: Range<String.Index>) -> NSRange {
//        let from = range.lowerBound.samePosition(in: utf16)
//        let to = range.upperBound.samePosition(in: utf16)
//        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from ?? 0),
//                       length: utf16.distance(from: from, to: to))
//    }
//
//    //Range转换为NSRange
//    func range(from nsRange: NSRange) -> Range<String.Index>? {
//        guard
//            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
//                                     limitedBy: utf16.endIndex),
//            let to16 = utf16.index(from16, offsetBy: nsRange.length,
//                                   limitedBy: utf16.endIndex),
//            let from = String.Index(from16, within: self),
//            let to = String.Index(to16, within: self)
//            else { return nil }
//        return from ..< to
//    }
//}
