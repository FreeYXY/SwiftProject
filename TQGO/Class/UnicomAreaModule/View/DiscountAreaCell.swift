//
//  DiscountAreaCell.swift
//  TQGO
//
//  Created by YXY on 2018/11/30.
//  Copyright © 2018 Techwis. All rights reserved.
//

import UIKit

class DiscountAreaCell: UITableViewCell {
    var iconImgV :UIImageView?
    var goodsNameLabel : UILabel?
    var goodsDescLabel :UILabel?
    var specialPriceLabel : UILabel?
    var counLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() -> Void {
        iconImgV = UIImageView()
        contentView.addSubview(iconImgV!)
        iconImgV?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 130, height: 104))
        }
        
        goodsNameLabel = UILabel()
        goodsNameLabel?.textColor = KCOLOR_Base.font_black
        goodsNameLabel?.font = .systemFont(ofSize: 14)
        contentView.addSubview(goodsNameLabel!)
        goodsNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(iconImgV!).offset(10)
            make.left.equalTo(iconImgV!.snp.right).offset(15)
            make.right.equalToSuperview().offset(-21)
        })
        
        goodsDescLabel = UILabel()
        goodsDescLabel?.textColor = KCOLOR_Base.font_gray
        goodsDescLabel?.font = .systemFont(ofSize: 12)
        contentView.addSubview(goodsDescLabel!)
        goodsDescLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(goodsNameLabel!.snp.bottom).offset(8)
            make.left.equalTo(goodsNameLabel!)
            make.right.equalTo(goodsNameLabel!)
        })
        
        counLabel = UILabel()
        counLabel?.textColor = KCOLOR_Base.font_gray
        counLabel?.font = .systemFont(ofSize: 10)
        contentView.addSubview(counLabel!)
        counLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(goodsDescLabel!.snp.bottom).offset(16)
            make.left.equalTo(goodsDescLabel!)
        })
        
        specialPriceLabel = UILabel()
        specialPriceLabel?.textColor = KCOLOR_Base.font_red
        specialPriceLabel?.font = .systemFont(ofSize: 10)
        contentView.addSubview(specialPriceLabel!)
        specialPriceLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(counLabel!.snp.bottom).offset(8)
            make.left.equalTo(counLabel!)
        })
        
        let view = UIView()
        view.backgroundColor = KCOLOR_Base.line
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        
    }
    
    func setModel(goodsModel:GoodsModel) -> Void {
        iconImgV?.kf.setImage(with: URL(string: goodsModel.imgUrl!), placeholder: UIImage(named: "icon_goods_default"), options: nil, progressBlock: nil, completionHandler: nil)
        goodsNameLabel?.text = goodsModel.goodsName
        goodsDescLabel?.text = goodsModel.tag
        specialPriceLabel?.text = goodsModel.payPrice
        counLabel?.text = goodsModel.goodsSell
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
