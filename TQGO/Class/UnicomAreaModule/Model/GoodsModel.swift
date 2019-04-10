//
//  GoodsModel.swift
//  TQGO
//
//  Created by YXY on 2018/11/28.
//  Copyright © 2018 Techwis. All rights reserved.
//

import Foundation

enum KGoodsType:String{
    case KGoodsType_GiftBag = "0"// 打包商品  礼包商品
    case KGoodsType_Virtual = "1"// 虚拟商品
    case KGoodsType_Entity = "2"// 实物商品
    case KGoodsType_3C = "3"// 3商品
}

enum KHideStatus:String{
    case KHideStatus_hide = "0"// 隐藏
    case KHideStatus_show = "1"// 显示
}


enum kShopcartstatus:String{
    case kShopcartstatus_normal = "0"// 0 有货
    case kShopcartstatus_wait = "1"// 1 补货中
    case kShopcartstatus_notEnough = "2"// 2 库存不足
    case kShopcartstatus_invalid = "3"// 已下架
}


class GoodsModel:HandyJSON{
    var goodsCode : String?
    var goodsName : String?
    var goodsType : String?
    var payPrice : String?
    var goodsNums : String?
    var goodsSell : String?
    var thumbnailUrl : String?
    var indexUrl : String?
    var hideStatus : String?
    var officialPrice : String?
    var imgUrl : String?
    var tags : String?
    var price : String?
    var tag : String?
    var goodsArea : String?
    var homeTitle : String?
    var homeContent : String?
    var cityStr : String?
    var menuCode : String?
    var bigPictureUrl : String?
    var goodsClassifyCode : String?
    var alreadySpec : String?
    var count : String?
    var goodsImgUrl : String?
    var taskId : String?
    var stock : String?
    var status : String?
    var isSelected : String?
    var token : String?
    var amount : String?
    var goodsImg : String?
    var unicomZoneType : String?
    
    required init() {}
}
