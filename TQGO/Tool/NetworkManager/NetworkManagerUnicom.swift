//
//  NetworkManagerUnicom.swift
//  TQGO
//
//  Created by YXY on 2018/11/15.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import SwiftyJSON

enum APIInterface {
    case queryUnicomZoneIndex(userNo:String,area:String)
    case queryPromoIndex(userNo:String,area:String,taskId:String,menuCode:String)
}

extension APIInterface{
    var path:String{
        switch self {
        case .queryUnicomZoneIndex:
            return "queryUnicomZoneIndex"
        case .queryPromoIndex:
            return "queryPromoIndex"
        }
    }
}
class NetworkManagerUnicom {
    static func loadData(api:APIInterface,completionClosure: @escaping successClosure,failClosure:@escaping failClosure) -> Void {
        switch api {
        case let .queryUnicomZoneIndex(userNo,area):
            
            var params = [String:Any]()
            
            if !userNo.isEmpty{
                params.updateValue(userNo, forKey: "userNo")
            }
            if !area.isEmpty{
                params.updateValue(area, forKey: "area")
            }
            
            NetworkManager.postRequest(interface:api.path , params: params as! Dictionary<String, String>, completion: { (resopne) -> (Void) in
                if let model = UnicomIndexModel.deserialize(from: resopne.toJSONString(), designatedPath: "data") {
                    resopne.data = model
                    completionClosure(resopne)
                }
            }) { (fail) -> (Void) in
                failClosure(fail)
            }
            return
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
