//
//  Macro.swift
//  TQGO
//
//  Created by YXY on 2018/7/10.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

@_exported import RxSwift
@_exported import RxCocoa
@_exported import RealmSwift
@_exported import HandyJSON
@_exported import SwiftyJSON
@_exported import Kingfisher
@_exported import Toast

let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width
let kSafeAreaBottomHeight:CGFloat  = (((kScreenHeight == 812.0 ) || (kScreenHeight == 896.0)) ? 34 : 0)
let kSafeAreaTopHeight:CGFloat = (((kScreenHeight == 812.0 ) || (kScreenHeight == 896.0)) ? 88 : 64)
let kSystemVersion = (UIDevice.current.systemVersion as NSString).floatValue
let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
let kMainScreenScale = UIScreen.main.scale
let kNavgationHeight = (CGFloat(kStatusBarHeight) + CGFloat(kNabBarHeight))
let kUserDefaults = UserDefaults.standard
let kNotife = NotificationCenter.default
let kAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
let kUUID =  UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "")
let kDate_Location = "zh_CN"
let kTabbarHeight = 49
let kNabBarHeight = 44
let kLineHeight = 0.5
let kSectionHeight:CGFloat = 48
let kMarginHeight = 8
let kLimitPhone = 11
let kLimitPassword = 16
let kLimitSecurityCode = 4

//获取命名空间，在info.plist文件里就是Executable file
let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
//拼接成固定格式
func YXYClassFromString(name:String) -> AnyClass{
    return NSClassFromString(nameSpace + "." + name)!
}

// 文件夹路径
struct kDirectoryPath {
    static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).last
    static let Library = NSSearchPathForDirectoriesInDomains(.libraryDirectory,.userDomainMask, true).last
    static let Tmp = NSTemporaryDirectory()
    static let Caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask, true).last
}

// 打印内容，并包含类名和打印所在行数
func DLog<T>(_ message : T,file : String = #file,function:String = #function, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let functionStr = function.split(separator: "(").first
    print("\n**************自定义日志输出：\(fileName):\(functionStr ?? "")():[\(lineNumber)]************** \n\(message) \n**************************************************")
    #endif
}

func kImage(name:String) -> UIImage?{
    return UIImage(named: name)
}

func kFont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}
   
func kRGBCOLOR(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
   return UIColor(red:  r/255.0, green: g/255.0, blue:  b/255.0, alpha: 1)
}

func kRGBACOLOR(r:CGFloat,g:CGFloat,b:CGFloat, a:CGFloat) -> UIColor{
    return UIColor(red:  r/255.0, green: g/255.0, blue:  b/255.0, alpha: a)
}

//RGB 16进制转换
func KRGBHEXCOLOR(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


