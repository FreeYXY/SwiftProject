
//
//  YXYPageView.swift
//  TQGO
//
//  Created by YXY on 2019/3/21.
//  Copyright © 2019 Techwis. All rights reserved.
//

class YXYPageView: UIView {
    
    lazy var segmentBarView: UIView = {
        let segmentBarView = UIView()
        return segmentBarView
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
