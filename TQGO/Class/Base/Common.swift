//
//  Common.swift
//  TQGO
//
//  Created by YXY on 2019/12/13.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import Contacts

// test 2

class Common {
    
    /// 通讯录授权
    static func getContactsAuthStatus() -> Bool {
        var authorizedMsg :String?
        var isAuthorized = false
      
        switch CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
        case CNAuthorizationStatus.notDetermined:do {
            authorizedMsg = "用户未确定是否授权"
            let contactStore = CNContactStore()
            let semaphore = DispatchSemaphore(value: 0)
            contactStore.requestAccess(for: CNEntityType.contacts) { (granted, error) in
                if (error !=  nil) {
                    isAuthorized = false
                    DLog("contact 授权 error：\(String(describing: error))");
                }else if(granted == false){
                    isAuthorized = false
                }else {
                    isAuthorized = true
                }
                semaphore.signal()
            }
            semaphore.wait()
            }
        case CNAuthorizationStatus.restricted:
            authorizedMsg = "iOS 设备上一些许可配置阻止程序与通讯录数据库进行交互"
            isAuthorized = false
        case CNAuthorizationStatus.denied:
            authorizedMsg = "用户明确的拒绝了你的程序对通讯录的访问"
            isAuthorized = false
        case CNAuthorizationStatus.authorized:
            authorizedMsg = "default 未知信息"
            isAuthorized = true
        default:
            authorizedMsg = "default 未知信息"
            isAuthorized = false
        }
        DLog("在iOS 9及以上设备上，通讯录授权信息：\(authorizedMsg!)\(isAuthorized))");
        return isAuthorized
    }
}

