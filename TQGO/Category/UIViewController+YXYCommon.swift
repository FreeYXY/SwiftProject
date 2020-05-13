//
//  UIViewController+YXYCommon.swift
//  TQGO
//
//  Created by YXY on 2019/11/5.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func loadingAnimating(isAnimating:Bool) {
        isAnimating ? self.view.makeToastActivity(ToastPosition.center) :  self.view.hideToastActivity()
    }
}
