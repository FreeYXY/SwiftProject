//
//  DispatchQueue+common.swift
//  TQGO
//
//  Created by YXY on 2019/3/25.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation

// pick
extension DispatchQueue{
    private static var _onceTracker = [String]()
    /// 单例 仅创建一次
    ///
    /// - Parameters:
    ///   - token: token
    ///   - block: 代码块
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
