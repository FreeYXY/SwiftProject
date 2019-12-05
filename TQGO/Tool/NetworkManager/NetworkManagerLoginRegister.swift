
//
//  NetworkManagerLoginRegister.swift
//  TQGO
//
//  Created by YXY on 2019/10/31.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation


enum APIInterfaceLoginRegister {
    case userLogin(params:[String:String])
    
}



extension APIInterfaceLoginRegister:APIInterfaceProtocol{
  
    var path:String{
        switch self {
        case .userLogin(_):
             return "userLogin"
        }
    }
    var parameters: [String : String]?{
        switch self {
        case .userLogin(let params):
            return  params
        }
    }
    
    
}
