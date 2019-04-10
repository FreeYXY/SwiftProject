//
//  HotCollectionViewCell.swift
//  TQGO
//
//  Created by YXY on 2018/11/20.
//  Copyright © 2018 Techwis. All rights reserved.
//

import UIKit

class HotCollectionViewCell: UICollectionViewCell {
    var goodsNameLabel:UILabel?
    var goodsDescLabel:UILabel?
    var goodsImg:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() -> Void {
        goodsImg = UIImageView()
        contentView.addSubview(goodsImg!)
        goodsImg?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(CGSize(width: 56, height: 56))
        }
       
        goodsNameLabel = UILabel()
        goodsNameLabel?.textColor = KCOLOR_Base.font_black
        goodsNameLabel?.font = .systemFont(ofSize: 14)
        contentView.addSubview(goodsNameLabel!)
        goodsNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(11)
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(goodsImg!.snp.left)
        })
        
        goodsDescLabel = UILabel()
        goodsDescLabel?.textColor = KCOLOR_Base.font_gray
        goodsDescLabel?.font = .systemFont(ofSize: 12)
        contentView.addSubview(goodsDescLabel!)
        goodsDescLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(goodsNameLabel!.snp.bottom).offset(8)
            make.left.equalTo(goodsNameLabel!)
            make.right.equalTo(goodsImg!.snp.left)
        })
    }
    
    func setModel(goodsModel:GoodsModel) -> Void {
        goodsImg?.kf.setImage(with: URL(string: goodsModel.imgUrl!), placeholder: UIImage(named: "icon_goods_default"), options: nil, progressBlock: nil, completionHandler: nil)
        goodsNameLabel?.text = goodsModel.goodsName
        goodsDescLabel?.text = goodsModel.tag
    }
    
}
