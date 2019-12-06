//
//  PromotionVC.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit
import RealmSwift
import MJRefresh

let kSlideViewH = (kScreenWidth * 135/375)
let kPageViewCell_id = "kPageViewCell_id"

class PromotionVC: UIViewController {
    var promotionModel:PromotionModel?
    var pageView:YXYPageContentView?
    var menuTitleView:YXYMenuTitleView?
    var canScroll = true
    
    lazy var tableView:BaseTableView = {
        let tableView = BaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ADCell.self, forCellReuseIdentifier: kADCell_id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kPageViewCell_id)
        view.addSubview(tableView)
        return tableView
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "促销"
    
        kNotife.addObserver(self, selector: #selector(changeScrollStatus), name: .kLeaveTop, object: nil)
    
        tableView.backgroundColor = .white
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [unowned self] in
            self.tableView.mj_header?.endRefreshing()
        })
        loadData()
    }
    
    func loadData() {
        var params = ["area":"110000",
                      "taskId": "",
                      "menuCode": ""]
        if let userNo = UserInfo.instance?.userNo {
            params.updateValue(userNo, forKey: kUserNo)
        }
        
        NetworkManager.loadData(api: APIInterfacePromotion.queryPromoIndex(params:params), completionClosure: { [weak self] (respone) -> (Void) in
            if respone.returnCode == KErrorCode.KErrorCode_SUCCESSE.rawValue{
                if let model = PromotionModel.deserialize(from: respone.toJSONString(), designatedPath: "data") {
                    self?.promotionModel = model
                    self?.tableView.reloadData()
                }
            }else{
                self?.readDataFromLocal()
            }
        }) {[weak self] (fail) -> (Void) in
            self?.readDataFromLocal()
        }
    }
    
    /// 子线程读取本地数据 主线程刷新
    func readDataFromLocal(){
        let tempModel = PromotionModel()
        DispatchQueue.global().async {
            let tempArr  = JSONDeserializer<MenuModel>.deserializeModelArrayFrom(array: "menu".getLocalPlistData()) as! Array<MenuModel>
            tempModel.menus = tempArr
            let tempArrBanner  = JSONDeserializer<SlideShowModel>.deserializeModelArrayFrom(array: "homeBanner".getLocalPlistData()) as! Array<SlideShowModel>
            tempModel.banners = tempArrBanner
            self.promotionModel = tempModel
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PromotionVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kSlideViewH
        }else{
            return kScreenHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }        
        var titleArr = [String]()
        promotionModel?.menus?.forEach({ (menu) in
            if let title = menu.name{
                titleArr.append(title)
            }
        })
        menuTitleView =  YXYMenuTitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40), titleArr: titleArr)
        menuTitleView!.menuMoveDelegate = self
        menuTitleView!.indicatorType = .YXYIndicatorTypeCustom
        menuTitleView!.indicatorExtension = 30;
        
        return menuTitleView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section  == 0 {
            let adCell = tableView.dequeueReusableCell(withIdentifier: kADCell_id, for: indexPath) as! ADCell
            if self.promotionModel?.banners?.isEmpty == false{
                 adCell.setSlideArr(banner: self.promotionModel?.banners)
            }
           
            return adCell
        }else{
            let contentCell = tableView.dequeueReusableCell(withIdentifier:kPageViewCell_id , for: indexPath)
            var subVCArr = [PromotionSubVC]()
            _ = promotionModel?.menus?.map({ (model)  in
                let vc = PromotionSubVC()
                vc.title = model.code
                vc.menuCode = model.code
                vc.taskId = promotionModel?.promos?.first?.taskId
                subVCArr.append(vc)
            })
            pageView?.removeFromSuperview()
            pageView = YXYPageContentView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), subVCArr:subVCArr, parentVC: self)
            contentCell.contentView.addSubview(pageView!)
            pageView!.pageContenViewDelegate = self
            return contentCell
        }
    }
}

extension PromotionVC:YXYMenuMoveProtocol,YXYContenViewProtocol{
    func pageContenViewDidScroll(fromIndex: NSInteger, toIndex: NSInteger) {
        menuTitleView!.selectIndex = toIndex
    }
    
    func menuMoveProtocol(formIndex: NSInteger, toIndex: NSInteger) {
        pageView!.contentViewCurrentIndex = toIndex
    }
}


extension PromotionVC{
    @objc func changeScrollStatus(){
        canScroll = true;
        _ = pageView?.subVCArr.map({ (vc)  in
            vc.vcCanScroll = false
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let bottomCellOffset = tableView.rect(forSection: 1).origin.y
        if (scrollView.contentOffset.y) >= bottomCellOffset {
            scrollView.contentOffset = CGPoint(x: 0, y: bottomCellOffset)
            if (canScroll) {
                canScroll = false;
                _ = pageView?.subVCArr.map({ (vc)  in
                     vc.vcCanScroll = true
                })
            }
        }else{
            if (!canScroll) {
                //子视图没到顶部
                scrollView.contentOffset = CGPoint(x: 0, y: bottomCellOffset)
            }
        }
    }
}
