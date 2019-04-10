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
    case queryPromoIndex(userNo:String,area:String,taskId:String,menuCode:String)
}

extension APIInterfacePromotion{
    var path:String{
        switch self {
        case .queryPromoIndex:
            return "queryPromoIndex"
        }
    }
}

class NetworkManagerPromotion {
    static func loadData(api:APIInterfacePromotion,completionClosure: @escaping successClosure,failClosure:@escaping failClosure) -> Void {
        switch api {
        case let .queryPromoIndex( userNo, area,taskId,menuCode):
            var params = [String:Any]()
            
            if !userNo.isEmpty{
                params.updateValue(userNo, forKey: "userNo")
            }
            if !area.isEmpty{
                params.updateValue(area, forKey: "area")
            }
            
            if !taskId.isEmpty{
                params.updateValue(taskId, forKey: "taskId")
            }
            if !menuCode.isEmpty{
                params.updateValue(menuCode, forKey: "menuCode")
            }
            
            NetworkManager.postRequest(interface:api.path , params: params as! Dictionary<String, String>, completion: { (resopne) -> (Void) in
                
                if let model = PromotionModel.deserialize(from: resopne.toJSONString(), designatedPath: "data") {
                    resopne.data = model
                    completionClosure(resopne)
                }
            }) { (fail) -> (Void) in
                failClosure(fail)
            }
            return
        }
    }
}
