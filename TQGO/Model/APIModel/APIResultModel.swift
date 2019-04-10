//
//  APIResultModel.swift
//  TQGO
//
//  Created by YXY on 2018/11/28.
//  Copyright © 2018 Techwis. All rights reserved.
//

import Foundation
//import HandyJSON

class APIResultModel: HandyJSON {
    var data : Any?
    var returnCode : String?
    var returnMsg :String?
  
    required init() {}
}

enum KErrorCode:String{
    
    case  KErrorCode_SUCCESSE = "1000"        // 成功
    case  KErrorCode_CODE1001 = "1001"       // 传入参数为空或不合法
    case  KErrorCode_CODE1002 = "1002"     // 数据异常
    case  KErrorCode_CODE1003 = "1003"       // 验签失败
    case  KErrorCode_CODE1004 = "1004"      // 组件编码错误
    
    case    KErrorCode_CODE1005 = "1005"        // 重复提交
    case    KErrorCode_CODE1006 = "1006"        // 商品售罄
    case    KErrorCode_CODE1007 = "1007"     // 商品已过期
    case    KErrorCode_CODE1008 = "1008"        // 商品已下线
    case    KErrorCode_CODE1009 = "1009"        // T币余额不足
    case    KErrorCode_CODE1030 = "1030"     // 无效卡
    case    KErrorCode_CODE1031 = "1031"      // 已失效
    
    case    KErrorCode_CODE2000 = "2000"        // 验证码发送失败
    case    KErrorCode_CODE2001 = "2001"        // 您已注册请登录
    case    KErrorCode_CODE2002 = "2002"        // 登录密码错误"
    case    KErrorCode_CODE2003 = "2003"        // 用户不存在
    case    KErrorCode_CODE2004 = "2004"     // 验证码错误
    case    KErrorCode_CODE2005 = "2005"        // 验证码超时
    case    KErrorCode_CODE2006 = "2006"        // 请注册之后再登陆
    case    KErrorCode_CODE2007 = "2007"        // 用户未实名
    
    case    KErrorCode_CODE3000 = "3000"         // 不支持该银行卡
    case    KErrorCode_CODE3001 = "3001"         // 绑卡失败
    case    KErrorCode_CODE3002 = "3002"         // 该银行卡已签约
    case    KErrorCode_CODE3003 = "3003"         // 银行验证失败
    case    KErrorCode_CODE3004 = "3004"         // 购买失败
    case    KErrorCode_CODE3005 = "3005"      // 购买金额不能大于剩余金额
    case    KErrorCode_CODE3006 = "3006"         // 加密错误
    case    KErrorCode_CODE3007 = "3007"         // 该证件号码已被实名
    case    KErrorCode_CODE3008 = "3008"         // 该银行卡未签约
    case    KErrorCode_CODE3009 = "3009"         // 该优惠劵不可用
    case    KErrorCode_CODE3010 = "3010"         // 该用户未绑定银行卡
    case    KErrorCode_CODE3011 = "3011"         // 该身份证已认证其他用户
    case    KErrorCode_CODE3012 = "3012"         // 身份证认证失败
    
    case    KErrorCode_CODE4000 = "4000"        // 产品已售罄
    case    KErrorCode_CODE4001 = "4001"        // 产品不存在
    case    KErrorCode_CODE4002 = "4002"        // 募集时间已结束
    
    case    KErrorCode_CODE5001 = "5001"     // 邀请人未参加邀请活动
    case    KErrorCode_CODE5002 = "5002"        // 活动已结束
    
    case    KErrorCode_CODE6001 = "6001"        // 请更新版本
    case    KErrorCode_CODE6002 = "6002"        // 已是最新版本
    
    case    KErrorCode_CODE8001 = "8001"     // 用户不在白名单内
    case    KErrorCode_CODE8002 = "8002"        // 用户在黑名单中
    case    KErrorCode_CODE8003 = "8003"        // 授信申请失败
    case    KErrorCode_CODE8004 = "8004"        // 启动活体识别验证失败
    
    case    KErrorCode_CODE9998 = "9998"        // 数据异常，请稍后
    case    KErrorCode_CODE9999 = "9999"        // 系统异常，请重试
    
    case    KErrorCode_Login_INVALID = "9990"   // 登录信息有误
    
    
}
