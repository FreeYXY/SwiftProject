//
//  PromotionSubVC.swift
//  TQGO
//
//  Created by YXY on 2019/3/22.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit


let kPromotionSubCell_id = "kPromotionSubCell_id"

class PromotionSubVC: UIViewController {
    
    var promotionModel:PromotionModel?
    var menuCode:String?
    var taskId :String?
    var vcCanScroll = false

    lazy var collectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        
        var height:CGFloat = 213+34+8+12;
        if(kScreenWidth <= 320) {
            height = 213-28+40;
        }else if(kScreenWidth >= 414){
            height = 213+34+20+8;
        }
        layout.itemSize = CGSize(width: (kScreenWidth-15*3)/2.0, height: height)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.width, height: kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false;
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PromotionSubCell.self, forCellWithReuseIdentifier:kPromotionSubCell_id)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        //        正式 01645200948672000591 测试64701103843409000591
        let params = ["userNo": "01645200948672000591",
                      "area":"110000",
                      "taskId":taskId ?? "a3e17811155f699c451b",
                      "menuCode": menuCode!]
        NetworkManager.loadData(api: APIInterfacePromotion.queryPromoIndex(params:params ), completionClosure: { [weak self] (respone) -> (Void) in
            
            if respone.returnCode == KErrorCode.KErrorCode_SUCCESSE.rawValue{
                self!.promotionModel = respone.data as? PromotionModel
                self!.collectionView.reloadData()
                
            
                
            }else{
               self!.readDataFromLocal()
            }
        }) {[weak self]  (fail) -> (Void) in
            self!.readDataFromLocal()
        }
        
    }
    /// 读取本地数据
    func readDataFromLocal(){
        let home = Bundle.main.path(forResource: "goods\(self.menuCode!)", ofType: "plist")
        let menuArr = NSArray(contentsOfFile: home!)
        let tempArr  = JSONDeserializer<GoodsModel>.deserializeModelArrayFrom(array: menuArr) as! Array<GoodsModel>
        let tempModel = PromotionModel()
        tempModel.activityGoods = tempArr
        self.promotionModel = tempModel
        self.collectionView.reloadData()
    }
    
}

extension PromotionSubVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.promotionModel?.activityGoods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPromotionSubCell_id, for: indexPath) as! PromotionSubCell
        let model = self.promotionModel?.activityGoods?[indexPath.row]
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(GoodsDetailVC(), animated: true)
    }
}

extension PromotionSubVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if vcCanScroll == false {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
        if scrollView.contentOffset.y <= 0 {
            vcCanScroll = false
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            //到顶通知父视图改变状态
            NotificationCenter.default.post(name:.kLeaveTop, object: nil)
        }
    }
}
