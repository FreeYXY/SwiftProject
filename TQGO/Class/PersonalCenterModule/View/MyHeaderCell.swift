//
//  MyHeaderCell.swift
//  TQGO
//
//  Created by YXY on 2019/10/21.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit

class MyHeaderCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = KCOLOR_Base.font_blue
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let iconImgV = UIImageView()
        iconImgV.image = UIImage(named: "icon_header")
        contentView.addSubview(iconImgV)
        iconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        let loginBtn = UIButton(type: UIButton.ButtonType.custom)
        loginBtn.isHidden = false
        loginBtn.setTitle("立即登录", for: UIControl.State.normal)
        loginBtn.setImage(kImage(name: "icon_arrow_right_white"), for: UIControl.State.normal)
        loginBtn.titleLabel?.font = kFont(size: 17)
        loginBtn.setTitleColor(.white, for: UIControl.State.normal)
        loginBtn.rx.tap.subscribe(onNext: {[weak self] (make) in
            self?.viewController()?.navigationController?.pushViewController(LoginVC(), animated: true)
        }).disposed(by: disposeBag)
        
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImgV.snp_rightMargin).offset(16)
            make.centerY.equalTo(iconImgV)
        }
        loginBtn.layoutButtonWithEdgeInsetsStyle(style: YXYButtonEdgeInsetsStyle.YXYButtonEdgeInsetsStyleRight, imageTitleSpace: 6)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
