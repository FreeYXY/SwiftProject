//
//  PromotionSubCell.swift
//  TQGO
//
//  Created by YXY on 2019/3/22.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit

class PromotionSubCell: UICollectionViewCell {
    
    var icon:UIImageView!
    var flagTwoLabel:UILabel!
    var goodsNameLabel:UILabel!
    var flagOneLabel:UILabel!
    var specialPriceLabel:UILabel!
    var buyGoodsBtn:UIButton!
    var officialPriceLabel:UILabel!
    var salesCountLabel:UILabel!
 
    var model:GoodsModel?{
        didSet{
            icon.kf.setImage(with: URL(string: (model?.imgUrl ?? "")), placeholder: UIImage.init(named: "icon_goods_default"), options: [KingfisherOptionsInfoItem.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            salesCountLabel.text = "月销" + (model?.goodsSell ?? "") + "件"
            goodsNameLabel.text = model?.goodsName ?? ""
            var tagArr = [String]()
            if (model?.tags?.isEmpty == false) {
                flagOneLabel.isHidden = false;
                flagTwoLabel.isHidden = false;
                tagArr = (model?.tags?.components(separatedBy:",")) ?? []
                if (tagArr.count > 1) {
                    self.flagOneLabel.text = "  " + (tagArr.last ?? "") + "  "
                    self.flagTwoLabel.text = "  " + (tagArr.first ?? "") + "  "
                }else if (tagArr.count > 0) {
                    self.flagOneLabel.text = "  " + (tagArr.first ?? "") + "  "
                }
            }else{
                flagOneLabel.isHidden = true;
                flagTwoLabel.isHidden = true;
            }
            
            let attStr =  NSMutableAttributedString(string: ("￥" + (model?.payPrice ?? "")))
            attStr.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10)], range:  NSRange(location: 0, length: 1))
             attStr.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)], range:  NSMakeRange(1, attStr.length-1))

            specialPriceLabel.attributedText = attStr;
            let newPrice =  NSMutableAttributedString(string: ("￥" + (model?.payPrice ?? "")))
            newPrice.addAttributes([.font : UIFont.systemFont(ofSize: 10)], range:  NSMakeRange(0, newPrice.length))
            newPrice.addAttributes([.strikethroughStyle:2], range:  NSMakeRange(0, newPrice.length))
            officialPriceLabel.attributedText = newPrice;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() -> Void {
        // 商品图片
        icon = UIImageView();
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(9)
            make.height.equalTo(icon.snp.width)
        }
  
        // 商品名
        goodsNameLabel = UILabel()
        goodsNameLabel.textColor = KCOLOR_Base.font_black
        goodsNameLabel.font = UIFont.systemFont(ofSize: 14)
        goodsNameLabel.lineBreakMode = .byTruncatingTail
        self.contentView.addSubview(goodsNameLabel)
        goodsNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(icon.snp.bottom).offset(9)
        }
        
        //特价
        specialPriceLabel = UILabel()
        specialPriceLabel.textColor = KCOLOR_Base.font_red;
        self.contentView.addSubview(specialPriceLabel);
        specialPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(goodsNameLabel);
            make.top.equalTo(goodsNameLabel.snp.bottom).offset(15-2);
        }
        
        // 标签一
        flagOneLabel = UILabel()
        flagOneLabel.layer.cornerRadius = 8
        flagOneLabel.layer.masksToBounds = true
        flagOneLabel.font = UIFont.systemFont(ofSize: 10)
        flagOneLabel.textColor = KCOLOR_Base.font_blue
        flagOneLabel.backgroundColor = KRGBHEXCOLOR(rgbValue: 0xE8F3FF)
        self.contentView.addSubview(flagOneLabel)
        flagOneLabel.snp.makeConstraints { (make) in
            make.right.equalTo(goodsNameLabel);
            make.centerY.equalTo(specialPriceLabel)
            make.height.equalTo(18)
            if (kScreenWidth <= 375) {
            make.width.lessThanOrEqualTo(70)
            }else{
            make.width.lessThanOrEqualTo(80)
            }
        }
        
        //    // 标签二
        flagTwoLabel = UILabel()
        flagTwoLabel.layer.cornerRadius = 8
        flagTwoLabel.layer.masksToBounds = true
        flagTwoLabel.font = UIFont.systemFont(ofSize: 10)
        flagTwoLabel.textColor = KRGBHEXCOLOR(rgbValue:0xff6c6c)
        flagTwoLabel.backgroundColor = kRGBCOLOR(r: 253, g: 240, b: 240)
        self.contentView.addSubview(flagTwoLabel)
        flagTwoLabel.snp.makeConstraints { (make) in
            make.right.equalTo(flagOneLabel.snp.left).offset(-5)
            make.top.equalTo(flagOneLabel)
            make.height.equalTo(flagOneLabel)
            if (kScreenWidth <= 375) {
            make.width.lessThanOrEqualTo(70)
            }else{
            make.width.lessThanOrEqualTo(80)
            }
        }
        
        // 官方价格
        officialPriceLabel = UILabel()
        officialPriceLabel.font = UIFont.systemFont(ofSize: 10)
        officialPriceLabel.textColor = KCOLOR_Base.font_textField;
        officialPriceLabel.textAlignment = .center
        self.contentView.addSubview(officialPriceLabel)
        officialPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(specialPriceLabel.snp.bottom).offset(8-2)
            make.left.equalTo(specialPriceLabel)
        }
        
        // 月销量
        salesCountLabel = UILabel()
        salesCountLabel.textColor = KCOLOR_Base.font_textField;
        salesCountLabel.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(salesCountLabel)
        salesCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(officialPriceLabel);
            make.right.equalTo(goodsNameLabel);
        }
    }
    
}
