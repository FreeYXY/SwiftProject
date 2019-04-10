//
//  UnicomIndexModel.swift
//  TQGO
//
//  Created by YXY on 2018/11/28.
//  Copyright © 2018 Techwis. All rights reserved.
//

import Foundation
//import HandyJSON



class UnicomIndexModel: HandyJSON {
    var banners:Array<SlideShowModel>?
    var recommGoods:Array<GoodsModel>?
    var discountZone:Array<GoodsModel>?
    required init() {}
}
