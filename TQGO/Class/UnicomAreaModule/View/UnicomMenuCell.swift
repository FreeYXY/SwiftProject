//
//  UnicomMenuCell.swift
//  TQGO
//
//  Created by YXY on 2018/11/13.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class UnicomMenuCell: UITableViewCell {
    
    var giftlabel:UILabel?
    var giftDescLabel:UILabel?
    var giftImagV : UIImageView?
    
    var phonelabel:UILabel?
    var phoneDescLabel:UILabel?
    var phoneImagV : UIImageView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style , reuseIdentifier: reuseIdentifier)
       self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() -> Void {
        giftlabel = UILabel()
        giftlabel?.text = "礼包专区"
        giftlabel?.textColor = KCOLOR_Base.font_black
        giftlabel?.font = .systemFont(ofSize: 16)
        contentView.addSubview(giftlabel!)
        giftlabel?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview().offset(-kScreenWidth/4)
        })
        giftDescLabel = UILabel()
        giftDescLabel?.text = "礼包随心选"
        giftDescLabel?.textColor = KCOLOR_Base.font_gray
        giftDescLabel?.font = .systemFont(ofSize: 12)
        contentView.addSubview(giftDescLabel!)
        giftDescLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(giftlabel!.snp.bottom).offset(8)
            make.centerX.equalTo(giftlabel!)
        })
        
        giftImagV = UIImageView()
        giftImagV?.image = UIImage.init(imageLiteralResourceName: "icon_gift_area")
        contentView.addSubview(giftImagV!)
        giftImagV?.snp.makeConstraints({ (make) in
            make.top.equalTo(giftDescLabel!.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 110, height: 60))
            make.centerX.equalTo(giftDescLabel!)
        })
       
        phonelabel = UILabel()
        phonelabel?.text = "手机专区"
        phonelabel?.textColor = KCOLOR_Base.font_black
        phonelabel?.font = .systemFont(ofSize: 16)
        contentView.addSubview(phonelabel!)
        phonelabel?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview().offset(kScreenWidth/4)
        })
        phoneDescLabel = UILabel()
        phoneDescLabel?.text = "手机畅想购"
        phoneDescLabel?.textColor = KCOLOR_Base.font_gray
        phoneDescLabel?.font = .systemFont(ofSize: 12)
        contentView.addSubview(phoneDescLabel!)
        phoneDescLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(phonelabel!.snp.bottom).offset(8)
            make.centerX.equalTo(phonelabel!)
        })
        
        phoneImagV = UIImageView()
        phoneImagV?.image = UIImage.init(imageLiteralResourceName: "icon_phone_area")
        contentView.addSubview(phoneImagV!)
        phoneImagV?.snp.makeConstraints({ (make) in
            make.top.equalTo(phoneDescLabel!.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 110, height: 60))
            make.centerX.equalTo(phoneDescLabel!)
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
