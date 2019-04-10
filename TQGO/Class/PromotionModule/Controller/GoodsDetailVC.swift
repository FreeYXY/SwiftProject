//
//  GoodsDetailVC.swift
//  TQGO
//
//  Created by YXY on 2019/1/15.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit

protocol GoodsDetailDelegate {
    func callback()
}

class GoodsDetailVC: UIViewController {
    
    var delegate:GoodsDetailDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "商品详情"
       self.delegate?.callback()
    }
    
}
