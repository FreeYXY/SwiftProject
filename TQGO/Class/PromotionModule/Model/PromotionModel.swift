//
//  PromotionModel.swift
//  TQGO
//
//  Created by YXY on 2019/3/20.
//  Copyright © 2019 Techwis. All rights reserved.
//

//import Foundation

class PromotionModel: HandyJSON {
    var promos:Array<PromosModel>?
    var banners:Array<SlideShowModel>?
    var menus:Array<MenuModel>?
    var activityGoods:Array<GoodsModel>?
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
//        mapper.specify(property: &promos, name: "id")
//         mapper <<< self.promos <-- "id"
    }

}
