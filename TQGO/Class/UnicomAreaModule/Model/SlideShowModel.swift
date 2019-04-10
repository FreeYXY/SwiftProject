//
//  SlideShowModel.swift
//  TQGO
//
//  Created by YXY on 2018/11/28.
//  Copyright © 2018 Techwis. All rights reserved.
//

import Foundation
//import HandyJSON

class SlideShowModel: HandyJSON {
    var imgUrl:String? // 图片路径
    var contentTitle:String?// 内容标题
    var descriptionInfo:String?// 描述
    var linkUrl:String?
    var showType:String?// 展示类型
    var endTime:String?// 结束时间
    var beginTime:String?// 开始时间
    var state:String?// 状态 0：下线 1上线
    var urlType:String?// 链接类型 1：内链接    2：外链接
    var bannerName:String?//标题
    var openType:String?// 1: APP内(各功能内跳转) 2: 外链(H5,其他外部链接)
    var openUrl:String?// 打开链接
    required init() {}
}
