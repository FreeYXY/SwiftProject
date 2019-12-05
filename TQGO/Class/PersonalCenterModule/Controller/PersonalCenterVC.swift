//
//  PersonalCenterVC.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class PersonalCenterVC: BaseVC {

    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyHeaderCell.self, forCellReuseIdentifier:"k")
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.top.equalToSuperview().offset(-kNabBarHeight)
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension PersonalCenterVC:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return  kSafeAreaBottomHeight > 0 ? 150+24.0 :150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return tableView.dequeueReusableCell(withIdentifier: "k", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
