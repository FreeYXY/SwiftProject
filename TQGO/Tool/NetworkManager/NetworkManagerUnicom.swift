//
//  NetworkManagerUnicom.swift
//  TQGO
//
//  Created by YXY on 2018/11/15.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import SwiftyJSON

enum APIInterfaceUnicom {
    case queryUnicomZoneIndex(params:[String:String])
}

extension APIInterfaceUnicom:APIInterfaceProtocol{
    var path:String{
        switch self {
        case .queryUnicomZoneIndex(_):
            return "queryUnicomZoneIndex"
        }
    }
    var parameters: [String : String]?{
        switch self {
        case .queryUnicomZoneIndex(let params):
            return  params
        }
    }
}
