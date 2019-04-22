//
//  HotGoodsCell.swift
//  TQGO
//
//  Created by YXY on 2018/11/19.
//  Copyright © 2018 Techwis. All rights reserved.
//

import UIKit

let kHotCollectionViewCell_id = "kHotCollectionViewCell_id"

class HotGoodsCell: UITableViewCell {
    var dataArr:Array<GoodsModel>?
    
    lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth/2, height: 80)
//        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: 48+8)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 80*2), collectionViewLayout: layout)
        collectionView.register(HotCollectionViewCell.self, forCellWithReuseIdentifier: kHotCollectionViewCell_id)
        collectionView.backgroundColor = UIColor.white

        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style , reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() -> Void {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(80*2)
        }
        containerView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HotGoodsCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func setDataArr(dataArr:Array<GoodsModel>) -> Void {
        self.dataArr = dataArr
        collectionView.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num = self.dataArr?.count ?? 0
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHotCollectionViewCell_id, for: indexPath) as? HotCollectionViewCell
        cell?.setModel(goodsModel: dataArr![indexPath.row])
        return cell!
    }
}


