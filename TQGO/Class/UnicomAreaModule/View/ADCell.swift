//
//  ADCell.swift
//  TQGO
//
//  Created by YXY on 2018/11/12.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class ADCell: UITableViewCell {
    var cycleScrollView:YXYBanner?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    func setupView() -> Void {
        cycleScrollView = YXYBanner()
        contentView.addSubview(cycleScrollView!)
        cycleScrollView?.placeholderImage = UIImage(named: "icon_home_banner_default")
        cycleScrollView!.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenWidth*150/375))
            make.edges.equalToSuperview()
        }
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
