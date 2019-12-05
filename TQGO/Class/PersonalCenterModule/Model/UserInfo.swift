//
//  UserInfo.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit
import RealmSwift

enum kUnicomStatus:NSInteger {
    case kUnicomStatus_open = 0 ,// 开通
    kUnicomStatus_unopen // 未开通
}

class UserInfo:Object,HandyJSON {
   
    @objc dynamic var userStatus:String?  // 用户状态 1：银卡 2：金卡
    @objc dynamic var userNo:String?// 用户号
    @objc dynamic var phoneNo:String? // 手机号
    @objc dynamic var integral:String?// 余额
    @objc dynamic var currency:String?// T币额度
    @objc dynamic var unicomeStatus:String?// 0：开启联通专区 1：未开启联通专区
    @objc dynamic var realType:String?// 实名状态  0：未认证  1：认证
    @objc dynamic var userToken:String?
    @objc dynamic var firstBuyStatus:String?//0: 未人脸识别 1: 已做过人脸识别
    @objc dynamic var receiveStatus:String?// 0 未领取 1：已领取 礼包领取状态
    @objc dynamic var openCreditPayStatus:String?// 0: 未开通 1: 已开通  信用付
    @objc dynamic var creditUsableMoney:String?// 授信可用额度
    @objc dynamic var creditStatus:String?// 授信状态 0.失败。1成功。2，未处理 3，处理中  4.授信过期 5待人工审核
    @objc dynamic var forzenStatus:String?// 冻结状态  0：冻结  1：未冻结
    @objc dynamic var userName:String?// 用户姓名
    @objc dynamic var idNo:String?// 身份证号
    @objc dynamic var totalCreditAmount:String?// 总额度
    @objc dynamic var alreadyUseAmount:String?// 已使用额度
    @objc dynamic var forzenCreditAmount:String?// 冻结额度
    @objc dynamic var thisMonthRefundAmount:String?// 本月应还
    @objc dynamic var nextMonthRefundAmount:String?//下月应还
    @objc dynamic var waitPayOrderNums:String?//代付款订单数
    @objc dynamic var lastMonthLeftAmout:String?// 上月未还账单金额
    @objc dynamic var maxRefundAmount:String?//最大还款金额
    
    
    override class func primaryKey()->String?{
        return "userNo";
    }

    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
//    override static func ignoredProperties() -> [String] {
//        return ["tempID"]
//    }
}

extension UserInfo{
    //MARK: 清空用户信息
    static func clearUserInfo(userNo:String?){
        let realm = RealmManager.instance
        realm.delete(UserInfo.instance!)
    }
    
    static var instance:UserInfo? = {
        let realm =  RealmManager.instance
        return  realm.objects(UserInfo.self).last
    }()
    
}
