//
//  AppConstant.swift
//  TQGO
//
//  Created by YXY on 2018/7/10.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import UIKit


#if DEBUG

let API_BASE = "http://www.YXY.com"  // 测试

#else
let API_BASE = "http://www.YXY.com"  // 正式
#endif


#if DEBUG


let API_UAPKEY =  "YXY"//测试 uapkey
let API_SECRET_KEY = "key=YXY" //测试环境  商户签名秘钥- key

let KDebugMode = true // debug 模式下，开启调试模式
let KBuglyChannel = "Debug"
let kDEBUGTYPE = true // 调试环境
let kJPUSH_ISProduction = false // 极光推送环境变量
let KBaiduMobStatLog_switch = true // 百度统计  测试环境开启日志输出 上线打开为yes  测试关闭为NO
let kFUPayKey  = "YXY"

#else


let API_UAPKEY  = "YXY" //正式 uapkey
let API_SECRET_KEY  = "key=YXY" //正式环境  商户签名秘钥- key

#endif

let KFooterHeight = 48
let kDeliveryTime = 1 // 预计发货时间
let kArrivaTime = 5   // 预计到货时间
let kUserNo = "kUserNo"

// 接口通用参数配置
let kPLATFORM_CODE = "YXY" // 平台编码
let kIP = "YXY" // 真实来源
let kAPI_ImageServer = "http://YXY/static"
let KBuglyAppId = "YXY"  // BuglyAppId
let KWXAppId = "YXY"// WXAppId
let KBaiduMobStatAppKey = "YXY"
let KJPUSHAppKey = "YXY"
let KAppScheme  = "YXY"
let KStagesPrice = "50"
let kAES128KEY = "YXY" // AES128KEY 与向量kInitVector值相同

// 百度统计时间ID
enum KBaiduMobStatID:String{
    case Promotion_Category_One =  "Promotion_Category_One"
    case Promotion_Category_Two = "Promotion_Category_Two"
    case Banner = "Banner"
    case UnicomBanner = "UnicomBanner"
    case HotListView = "HotListView"
    case DiscountArea = "DiscountArea"
    case GoodsDetailShare = "GoodsDetailShare"
    case ViewTextDetailShare = "ViewTextDetailShare"
    case GoodsDetailBuy = "GoodsDetailBuy"
    case GiftCardExchange = "GiftCardExchange"
    case Recharge = "Recharge"
    case Login = "Login"
    case Register = "Register"
    case GetGiftBag = "GetGiftBag"
    case PhoneMenu = "PhoneMenu"
    case GiftBagMenu = "GiftBagMenu"
    case GoodsSearch = "GoodsSearch"
    case SubmitOrder = "SubmitOrder"
    case CreditPayList  = "CreditPayList"
    case MakeSurePay = "MakeSurePay"
    case AuthActivate = "AuthActivate"
    case Repay = "Repay"
}

// 基础配色
struct KCOLOR_Base {
    static let viewBackground = KRGBHEXCOLOR(rgbValue:0xf7f7f7)  // f5f5f5
    static let font_golden = KRGBHEXCOLOR(rgbValue:0xd2aa60)
    static let statusBar    =  kRGBCOLOR(r:0,g:11,b:15)
    static let font_red = KRGBHEXCOLOR(rgbValue:0xff6c6c)
    static let line  = KRGBHEXCOLOR(rgbValue:0xe7e8ed)
    static let font_black  = KRGBHEXCOLOR(rgbValue:0x3a404c)
    static let font_blue =  KRGBHEXCOLOR(rgbValue:0x3b9afe)
    static let font_gray  = KRGBHEXCOLOR(rgbValue:0x92969f)
    static let font_textField =  KRGBHEXCOLOR(rgbValue:0xb9bdc6)
}


