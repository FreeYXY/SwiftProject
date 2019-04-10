//
//  BaseNavigationController.swift
//  TQGO
//
//  Created by YXY on 2018/7/9.
//  Copyright © 2018年 Techwis. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(viewControllers.count > 0){
            // 隐藏底部tabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        //判断即将到栈底
        if (viewControllers.count == 0) {
            //显示自定义的tabBar
            tabBarController?.tabBar.isHidden = false;
        }
        //  pop出栈
        return super.popViewController(animated: animated)
    }
}
