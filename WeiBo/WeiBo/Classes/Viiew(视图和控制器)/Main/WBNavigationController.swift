//
//  WBNavigationController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    //重写push方法 所有push动作都会调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            //隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
        }
        
       
        
        super.pushViewController(viewController, animated: true)
        
        
        

    }
}
