//
//  NetworkManagerPromotion.swift
//  TQGO
//
//  Created by YXY on 2019/3/19.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import SwiftyJSON


enum APIInterfacePromotion {
    case queryPromoIndex(params:[String:String])
}

extension APIInterfacePromotion:APIInterfaceProtocol{
    var path:String{
        switch self {
        case .queryPromoIndex:
            return "queryPromoIndex"
        }
    }
    
    var parameters: [String : String]?{
        switch self {
        case .queryPromoIndex(let params):
            return  params
        }
    }
}

