//
//  BaseTableView.swift
//  TQGO
//
//  Created by YXY on 2019/4/9.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

}

// 实现识别多手势代理
extension BaseTableView:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
