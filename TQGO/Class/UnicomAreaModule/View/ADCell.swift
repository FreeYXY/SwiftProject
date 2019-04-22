//
//  ADCell.swift
//  TQGO
//
//  Created by YXY on 2018/11/12.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class ADCell: UITableViewCell {
    var cycleScrollView:YXYCycleScrollView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    func setupView() -> Void {
        cycleScrollView = YXYCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth*150/375))
        contentView.addSubview(cycleScrollView!)
        cycleScrollView?.placeholderImage = UIImage(named: "icon_home_banner_default")
        cycleScrollView!.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenWidth*150/375))
            make.edges.equalToSuperview()
        }
//        cycleScrollView.setNeedsLayout()
//        cycleScrollView.layoutIfNeeded()
//        cycleScrollView.imageURLStringsGroup = ["http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg","http://www.techwis.cn/privilegeGo/image/1543909847890.jpg","http://www.techwis.cn/privilegeGo/image/1511955924958.png","http://www.techwis.cn/privilegeGo/image/1533260373656.png"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    
    func setSlideArr(banner:[SlideShowModel]?) -> Void {
        var urlsArr : [String] = []
        if banner?.count != 0{
            for model in banner! {
                if model.imgUrl?.isEmpty == false{
                    urlsArr.append(model.imgUrl!)
                }
            }
        }
        
        self.cycleScrollView!.imageURLStringsGroup = urlsArr
    }
}
