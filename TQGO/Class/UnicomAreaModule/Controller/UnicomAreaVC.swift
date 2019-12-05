//
//  UnicomAreaVC.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit
import MJRefresh

let kADCell_id = "kADCell_id"
let kUnicomMenuCell_id = "kUnicomMenuCell_id"
let kHotGoodsCell_id = "kHotGoodsCell_id"
let kDiscountAreaCell_id = "kDiscountAreaCell_id"

class UnicomAreaVC: UIViewController,UITextFieldDelegate,GoodsDetailDelegate{

    var  navbarView:UIView?
    var  searchTF:UITextField?
    var  unicomIndexModel:UnicomIndexModel?
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ADCell.self, forCellReuseIdentifier: kADCell_id)
        tableView.register(UnicomMenuCell.self, forCellReuseIdentifier: kUnicomMenuCell_id)
        tableView.register(HotGoodsCell.self, forCellReuseIdentifier: kHotGoodsCell_id)
        tableView.register(DiscountAreaCell.self, forCellReuseIdentifier: kDiscountAreaCell_id)
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(navbarView!.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        })
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "联通专区"
        view.backgroundColor = .white
        addSearchNav()
        tableView.backgroundColor = .white
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData()
        })
        loadData()
    }
    
    func loadData() -> Void {
     
        let dict = [kUserNo:"YXY" , "area": "110000"]
        NetworkManager.loadData(api: APIInterfaceUnicom.queryUnicomZoneIndex(params: dict), completionClosure: {[weak self] (respone) -> (Void) in
            self!.tableView.mj_header?.endRefreshing()
            if respone.returnCode == KErrorCode.KErrorCode_SUCCESSE.rawValue{
                self!.unicomIndexModel = respone.data as? UnicomIndexModel
                self!.tableView.reloadData()
                
            }else{
                self!.readDataFromLocal()
            }
        }) {[weak self] (fail) -> (Void) in
            self!.tableView.mj_header?.endRefreshing()
            self!.readDataFromLocal()
        }
    }
    
    /// 读取本地数据
    func readDataFromLocal(){
        let homeDiscountZone = Bundle.main.path(forResource: "UnicomAreaDiscountZone", ofType: "plist")
        let menuArrDiscountZone = NSArray(contentsOfFile: homeDiscountZone!)
        let tempArrDiscountZone  = JSONDeserializer<GoodsModel>.deserializeModelArrayFrom(array: menuArrDiscountZone) as! Array<GoodsModel>
        let tempModel = UnicomIndexModel()
        tempModel.discountZone = tempArrDiscountZone
    
        let homeRecommGoods = Bundle.main.path(forResource: "UnicomAreaRecommGoods", ofType: "plist")
        let menuArrRecommGoods = NSArray(contentsOfFile: homeRecommGoods!)
        let tempArrRecommGoods  = JSONDeserializer<GoodsModel>.deserializeModelArrayFrom(array: menuArrRecommGoods) as! Array<GoodsModel>
        tempModel.recommGoods = tempArrRecommGoods
        
        let homeBanner = Bundle.main.path(forResource: "UnicomBanner", ofType: "plist")
        let menuArrBanner = NSArray(contentsOfFile: homeBanner!)
        let tempArrBanner  = JSONDeserializer<SlideShowModel>.deserializeModelArrayFrom(array: menuArrBanner) as! Array<SlideShowModel>
        tempModel.banners = tempArrBanner
        self.unicomIndexModel = tempModel
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addSearchNav() -> Void {
        
        var y = 20.0;
        if  kSafeAreaBottomHeight != 0{
            y = 44.0;
        }
        navbarView = UIView.init(frame: CGRect(x: 0.0, y: y, width:Double(CGFloat(kScreenWidth)), height: 44.0))
        navbarView!.backgroundColor = .white

        // 搜索框
        let radiusValue:CGFloat = 15;
        searchTF = UITextField();
        searchTF!.delegate = self ;
        searchTF!.font = UIFont.systemFont(ofSize: 14);
        searchTF!.textColor = KCOLOR_Base.font_textField;
        searchTF!.backgroundColor = KRGBHEXCOLOR(rgbValue:0xf3f3f3);
        searchTF!.layer.cornerRadius = radiusValue;
        searchTF!.placeholder = "商品搜索";
        let bgV:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 30))
        bgV.backgroundColor = KRGBHEXCOLOR(rgbValue:0xf3f3f3);
        bgV.layer.cornerRadius = radiusValue;
        bgV.layer.masksToBounds = true;

        let imageV = UIImageView(image: UIImage.init(imageLiteralResourceName:"icon_search" ))
        bgV.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgV);
            make.centerY.equalTo(bgV);
        }

        searchTF!.leftView = bgV;
        searchTF!.leftViewMode = .always;
        navbarView!.addSubview(searchTF!)
        searchTF!.snp.makeConstraints { (make) in
            make.left.equalTo(15);
            make.centerY.equalTo(navbarView!);
            make.right.equalTo(-15);
            make.height.equalTo(30);
        }
        view.addSubview(navbarView!);
    }
}

extension UnicomAreaVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 {
            return 1
        }else{
            return unicomIndexModel?.discountZone?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let adCell = tableView.dequeueReusableCell(withIdentifier: kADCell_id, for: indexPath) as! ADCell
            let count = self.unicomIndexModel?.banners?.count
            if count ?? 0 > 0 {
                adCell.setSlideArr(banner: (self.unicomIndexModel?.banners!)!)
            }
            return adCell
        }else if indexPath.section == 1 {
            let menuCell = tableView.dequeueReusableCell(withIdentifier: kUnicomMenuCell_id, for: indexPath)
            return menuCell
        }else if indexPath.section == 2 {
            let hotcell = tableView.dequeueReusableCell(withIdentifier: kHotGoodsCell_id, for: indexPath) as? HotGoodsCell
            if (unicomIndexModel?.recommGoods?.count) != nil{
                hotcell?.setDataArr(dataArr:(unicomIndexModel?.recommGoods)!)
            }
            return hotcell!
        }else{
            let discountCell = tableView.dequeueReusableCell(withIdentifier: kDiscountAreaCell_id, for: indexPath) as? DiscountAreaCell
            if (unicomIndexModel?.discountZone?.count) != nil{
                discountCell?.setModel(goodsModel: (unicomIndexModel?.discountZone![indexPath.row])!)
            }
            return discountCell!
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let goodsDetailVC = GoodsDetailVC()
        goodsDetailVC.delegate = self
        self.navigationController?.pushViewController(goodsDetailVC, animated: true)
    }
    
    func callback() {
        DLog(message: "++++++++++++++++++____________+++++++++++++++++")
    }
    
}
