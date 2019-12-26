//
//  NetworkManager.swift
//  TQGO
//
//  Created by YXY on 2018/11/14.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import Foundation
import Alamofire

typealias successClosure = (APIResultModel) -> (Void)
typealias failClosure = (Any) -> (Void)

public enum APIError {
    case apiError_done  // 请求成功
    case apiError_netError(String) // 请求失败  网络 原因
    case apiError_serverMessage(String)  // 请求失败  服务器原因
}

protocol APIInterfaceProtocol {
    var path:String {get}
    var parameters: [String: String]? { get }
  
}

class NetworkManager {
   
    private static var sharedSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 0.2//请求超时时间
        return SessionManager(configuration: configuration)
    }()

    private static func commonAPIParameters()->Dictionary<String,String>{
        let userInfo = UserInfo.instance
        
        var parameters = [String : String]()
        parameters.updateValue(API_UAPKEY, forKey: "uapkey")
        parameters.updateValue(flowNumber(), forKey: "flowNo")
        parameters.updateValue(kPLATFORM_CODE, forKey: "platformCode")
        parameters.updateValue("2", forKey: "terminalType")
        parameters.updateValue(String.nowTimeWithFormat(format: kTimeFormat.format_yyyyMdHms.rawValue), forKey: "ts")
        parameters.updateValue(kIP, forKey: "ip")
        parameters.updateValue(kUUID!, forKey: "mac")
        parameters.updateValue("1", forKey: "dtype")
        parameters.updateValue(UIDevice.current.modelName, forKey: "brand")
        parameters.updateValue(kAppVersion as! String, forKey: "ver")
        if userInfo?.userNo != nil {
            parameters.updateValue("1", forKey: "userToken")
        }
        return parameters
    }
    
    //  生成随机数 yyyyMMddHHmmss+6位数
    private static func flowNumber()-> String {
        let timeSpan = String.nowTimeWithFormat(format:"yyyyMMddHHmmss")
        let randomNum = String(format: "%d", 100000 + (arc4random() % 100001))
        let flowNumber = String(format: "%@%@", timeSpan,randomNum)
        return flowNumber
    }
    
    // 生成签名参数
    private static func SignParameters(params:[String:AnyObject])->Dictionary<String,AnyObject>{//Dictionary<String, AnyObject>
        //参数排序
        var parameters = params
        let keyArray = params.keys.sorted()
        var jointParamsStr = ""
        for key in keyArray {
            var val:AnyObject
            if key == "appMap" {
                val = ((params[key]! as! Dictionary<String, String>) as NSObject).modelToJSONString as AnyObject
                val = (val as! String).replacingOccurrences(of: "\\/", with: "/") as AnyObject// 过滤AESBase64加密后带\字符的情况
            }else{
                val = params[key]!;
            }
            let itemUrl = String(format: "%@=%@",key,val as! String)
            jointParamsStr = String(format: "%@%@|", jointParamsStr,itemUrl)
        }
        // 拼接商户的秘钥
        jointParamsStr = String(format: "%@%@", jointParamsStr,API_SECRET_KEY);
        DLog("\n************拼接商户的秘钥后的管道数据************：\n \(jointParamsStr)")
        // MD5加密
        let signStr = jointParamsStr.md5;
        parameters["sign"] = signStr as AnyObject
        DLog("\n************完成签名参数************:\n\(parameters)");
        return parameters
    }
    
    private static func postRequest(interface:String,params:Dictionary<String,String>,completion:@escaping successClosure,failed:@escaping failClosure){
        // 构建全部参数
        var  commonParas = commonAPIParameters() as [String : AnyObject]
        commonParas["operation"] = interface  as AnyObject
        
        if params.isEmpty {
            commonParas.updateValue( "" as AnyObject, forKey: "appMap")
        }else{
            commonParas["appMap"] = params as AnyObject
        }
        
        // 生成签名参数sign
        let paramDict =  SignParameters(params: commonParas )
        let headers: HTTPHeaders = [
            "Accept": "application/json,text/json,text/javascript,text/plain,text/html",
            "Content-type" : "application/json"
        ]
      
        sharedSessionManager.request(API_BASE ,
                          method: .post,
                          parameters: paramDict,
                          encoding:JSONEncoding.default,
                          headers:headers).responseJSON{ (response) in
                            switch response.result {
                            case .success(let value):
                                DLog("接口路径：||-------------" + interface + "-------------||")
                                DLog(JSON(value))
                                completion(APIResultModel.deserialize(from:value as? Dictionary) ?? APIResultModel())
                                return
                            case .failure(let error):
                                DLog(String(describing: error))
                                failed(error)
                                
                                return
                            }
        }
        
        //    Alamofire.request(API_BASE ,
        //                      method: .post,
        //                      parameters: paramDict,
        //                      encoding:JSONEncoding.default,
        //                      headers:headers).responseString { (response) in
        //                        switch response.result {
        //                        case .success(let value):
        //                            if value.isEmpty{
        //                                DLog(message: "-------请求结果为空------")
        //                                return
        //                            }else{
        //                                let str = try? JSON(data: value.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.mutableContainers)
        //                                DLog(message:"接口路径：||-------------" + interface + "-------------||")
        //                                DLog(message: str)
        //                                completion(APIResultModel.deserialize(from:value)!)
        //                                return
        //                            }
        //                        case .failure(let error):
        //                            DLog(message: String(describing: error))
        //                            failed(error)
        //                            return
        //                        }
        //    }
    }
    
    static func loadData(api:APIInterfaceProtocol,completionClosure: @escaping successClosure,failClosure:@escaping failClosure) -> Void {
        var paramsDict = [String:String]()
        _ = api.parameters?.map({ (key, value)  in
            if !value.isEmpty {
                paramsDict.updateValue(value , forKey: key)
            }
        })
        NetworkManager.postRequest(interface:api.path , params: paramsDict, completion: { (resopne) -> (Void) in
            completionClosure(resopne)
        }) { (fail) -> (Void) in
            failClosure(fail)
        }
    }
}
