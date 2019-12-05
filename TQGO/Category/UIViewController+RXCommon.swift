//
//  UIViewController+RXCommon.swift
//  TQGO
//
//  Created by YXY on 2019/11/5.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation


extension Reactive where Base: UIViewController {
    /// 用于 `startAnimating()` 和 `stopAnimating()` 方法的 binder
    public var isLoadingAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            vc.loadingAnimating(isAnimating: active)
        })
    }
}


