//
//  UIDevice+Common.swift
//  TQGO
//
//  Created by YXY on 2018/7/11.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import UIKit


extension UIDevice {
    /// 获取设备具体详细的型号
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        //        struct utsname systemInfo;
        //        uname(&systemInfo);
        //        NSString *platform = [NSString stringWithCString:systemInfo.machine
        //        encoding:NSUTF8StringEncoding];
        
        switch identifier {
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1":                               return "iPhone 7 (CDMA)"
        case "iPhone9,3":                               return "iPhone 7 (GSM)"
        case "iPhone9,2":                               return "iPhone 7 Plus (CDMA)"
        case "iPhone9,4":                               return "iPhone 7 Plus (GSM)"
        case "iPhone10,1","iPhone10,4":                 return "iPhone 8"
        case "iPhone10,2","iPhone10,5":                 return "iPhone 8 Plus"
            
        case "iPhone10,3","iPhone10,6":                 return "iPhone X"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone11,2":                              return "iPhone Xs"
        case "iPhone11,4","iPhone11,6":                 return "iPhone XsMax"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
            
        case "iPad1,1": return "iPad 1"
        case "iPad2,1": return "iPad 2"
        case "iPad2,2": return "iPad 2"
        case "iPad2,3": return "iPad 2"
        case "iPad2,4": return "iPad 2"
        case "iPad3,1": return "iPad 3rd"
        case "iPad3,2": return "iPad 3rd"
        case "iPad3,3": return "iPad 3rd"
        case "iPad3,4": return "iPad 4th"
        case "iPad3,5": return "iPad 4th"
        case "iPad3,6": return "iPad 4th"
        case "iPad6,11": return "iPad 5th"
        case "iPad6,12": return "iPad 5th"
        case "iPad7,5": return "iPad 6th"
        case "iPad7,6": return "iPad 6th"
        case "iPad7,11": return "iPad 7th"
        case "iPad7,12": return "iPad 7th"
            
        case "iPad2,5": return "iPad Mini"
        case "iPad2,6": return "iPad Mini"
        case "iPad2,7": return "iPad Mini"
        case "iPad4,4": return "iPad Mini 2"
        case "iPad4,5": return "iPad Mini 2"
        case "iPad4,6": return "iPad Mini 2"
        case "iPad4,7": return "iPad Mini 3"
        case "iPad4,8": return "iPad Mini 3"
        case "iPad4,9": return "iPad Mini 3"
        case "iPad5,1": return "iPad Mini 4"
        case "iPad5,2": return "iPad Mini 4"
        case "iPad11,1": return "iPad Mini 5"
        case "iPad11,2": return "iPad Mini 5"
            
        case "iPad4,1": return "iPad Air"
        case "iPad4,2": return "iPad Air"
        case "iPad4,3": return "iPad Air"
        case "iPad5,3": return "iPad Air 2"
        case "iPad5,4": return "iPad Air 2"
        case "iPad11,3": return "iPad Air 3rd"
        case "iPad11,4": return "iPad Air 3rd"
            
        case "iPad6,7": return "iPad Pro 12.9-inch 1st"
        case "iPad6,8": return "iPad Pro 12.9-inch 1st"
        case "iPad6,3": return "iPad Pro 9.7-inch"
        case "iPad6,4": return "iPad Pro 9.7-inch"
        case "iPad7,1": return "iPad Pro 12.9-inch 2nd"
        case "iPad7,2": return "iPad Pro 12.9-inch 2nd"
        case "iPad7,3": return "iPad Pro 10.5-inch"
        case "iPad7,4": return "iPad Pro 10.5-inch"
        case "iPad8,5": return "iPad Pro 12.9-inch 3rd"
        case "iPad8,6": return "iPad Pro 12.9-inch 3rd"
        case "iPad8,7": return "iPad Pro 12.9-inch 3rd"
        case "iPad8,8": return "iPad Pro 12.9-inch 3rd"
        case "iPad8,1": return "iPad Pro 11-inch"
        case "iPad8,2": return "iPad Pro 11-inch"
        case "iPad8,3": return "iPad Pro 11-inch"
        case "iPad8,4": return "iPad Pro 11-inch"
            
        case "iPod1,1": return "iPod Touch 1st"
        case "iPod2,1": return "iPod Touch 2nd"
        case "iPod3,1": return "iPod Touch 3rd"
        case "iPod4,1": return "iPod Touch 4th"
        case "iPod5,1": return "iPod Touch 5th"
        case "iPod7,1": return "iPod Touch 6th"
            
        case "i386", "x86_64":                          return "iPhone Simulator"
            
        default:                                        return identifier
        }
    }
}

