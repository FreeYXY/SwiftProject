//
//  BaseVC.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if title == "我的" || title == "联通专区" {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if title == "我的" || title == "联通专区" {
            navigationController?.navigationBar.isHidden = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
