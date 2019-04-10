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

class UserInfo: Object {
    
    var userStatus:String?  // 用户状态 1：银卡 2：金卡
    var userNo:String?// 用户号
    var phoneNo:String? // 手机号
    var integral:String?// 余额
    var currency:String?// T币额度
    var unicomeStatus:String?// 0：开启联通专区 1：未开启联通专区
    var realType:String?// 实名状态  0：未认证  1：认证
    var userToken:String?
    var firstBuyStatus:String?//0: 未人脸识别 1: 已做过人脸识别
    var receiveStatus:String?// 0 未领取 1：已领取 礼包领取状态
    var openCreditPayStatus:String?// 0: 未开通 1: 已开通  信用付
    var creditUsableMoney:String?// 授信可用额度
    var creditStatus:String?// 授信状态 0.失败。1成功。2，未处理 3，处理中  4.授信过期 5待人工审核
    var forzenStatus:String?// 冻结状态  0：冻结  1：未冻结
    var userName:String?// 用户姓名
    var idNo:String?// 身份证号
    var totalCreditAmount:String?// 总额度
    var alreadyUseAmount:String?// 已使用额度
    var forzenCreditAmount:String?// 冻结额度
    var thisMonthRefundAmount:String?// 本月应还
    var nextMonthRefundAmount:String?//下月应还
    var waitPayOrderNums:String?//代付款订单数
    var lastMonthLeftAmout:String?// 上月未还账单金额
    var maxRefundAmount:String?//最大还款金额
    static var shareUserInfo:UserInfo?
    
    override class func primaryKey()->String?{
        return "userNo";
    }

}

extension UserInfo{
    static func setCurrentUserNo(userNo:String?){
        kUserDefaults.set(userNo, forKey: kUserNo)
        kUserDefaults.synchronize()
        if  userNo == nil {
            let realm = try! Realm()
            realm.deleteAll()
            shareUserInfo = nil;
        }
    }
    
    static func getCurrentUserNo() -> String?{
        return kUserDefaults.string(forKey: kUserNo)
    }
    
    static func getCurrentInstance() -> UserInfo?{
        if shareUserInfo == nil{
            if  getCurrentUserNo() == nil {
                let realm = try! Realm()
                shareUserInfo = realm.objects(UserInfo.self).last
            }
        }
        return shareUserInfo;
    }
}
