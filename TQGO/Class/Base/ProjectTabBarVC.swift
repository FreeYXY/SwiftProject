//
//  ProjectTabBarVC.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class ProjectTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let promVC = PromotionVC()
        let creditPay = CreditPayVC()
        let pcVC = PersonalCenterVC()
        let unicomAreaVC = UnicomAreaVC()
        let shopCartVC = ShopCartVC()
        
        let baseNav_1 = BaseNavigationController(rootViewController: promVC)
        let baseNav_2 = BaseNavigationController(rootViewController: unicomAreaVC)
        let baseNav_3 = BaseNavigationController(rootViewController: creditPay)
        let baseNav_4 = BaseNavigationController(rootViewController: shopCartVC)
        let baseNav_5 = BaseNavigationController(rootViewController: pcVC)
        
        let barItem_1 = UITabBarItem(title: "促销", image: UIImage(named:"icon_tabbar_default_promotion"), selectedImage: UIImage(named: "icon_tabbar_selected_promotion"))
         let barItem_2 = UITabBarItem(title: "联通专区", image: UIImage(named:"icon_tabbar_default_promotion"), selectedImage: UIImage(named: "icon_tabbar_selected_promotion"))
        let barItem_3 = UITabBarItem(title: "信用付", image: UIImage(named:"icon_tabbar_default_credit"), selectedImage: UIImage(named: "icon_tabbar_selected_credit"))
        let barItem_4 = UITabBarItem(title: "购物车", image: UIImage(named:"icon_tabbar_default_personalCenter"), selectedImage: UIImage(named: "icon_tabbar_selected_personalCenter"))
        let barItem_5 = UITabBarItem(title: "我的", image: UIImage(named:"icon_tabbar_default_personalCenter"), selectedImage: UIImage(named: "icon_tabbar_selected_personalCenter"))
        
        baseNav_1.tabBarItem = barItem_1
        baseNav_2.tabBarItem = barItem_2
        baseNav_3.tabBarItem = barItem_3
        baseNav_4.tabBarItem = barItem_4
        baseNav_5.tabBarItem = barItem_5
        viewControllers = [baseNav_1,baseNav_2,baseNav_3,baseNav_4,baseNav_5]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
