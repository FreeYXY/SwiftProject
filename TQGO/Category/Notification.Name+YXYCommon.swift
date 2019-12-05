//
//  Notification.Name+YXYCommon.swift
//  TQGO
//
//  Created by YXY on 2019/11/15.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation


extension Notification.Name{
    
    // 通知key 避免key重复
  private enum kNotify_Key:String {
        case ShopcartNum //购物车角标数
        case RefreshData // 商品兑换成功或失败后刷新数据
        case RefreshGift // 一次性领取礼包后刷新数据
        case LoginOut // 退出登录后刷新数据
        case Login //登录后刷新数据
        case ChangeCity// 切换城市后刷新数据
        case RefreshGood //  兑换商品后刷新商品列表数据
        case WXpay // 微信支付处理数据
        case CityCode//  当前选择的城市编码
        case CurrentCity //// 当前选择的城市名称
        case LocationCity//  当前定位的城市名称
        case LocationCityCode /// 当前定位的城市编码
        case IsHiddenrechargeButton //   0 不可购买  1可购买
        case OrderNo //  下单流水号
        case More // 领取礼包点击查看更多
        case safeName //
        case safeIDNO //
        case LeaveTop //= "kLeaveTop" //首页滑动通知
    }
    public static let kLeaveTop = Notification.Name("com.techwis.\(kNotify_Key.LeaveTop)")
    public static let kShopcartNum = Notification.Name("com.techwis.\(kNotify_Key.ShopcartNum)")
}
