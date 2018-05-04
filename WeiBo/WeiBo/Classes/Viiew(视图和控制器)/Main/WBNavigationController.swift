//
//  WBNavigationController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        
        
            
    }
    
    
    //重写push方法 所有push动作都会调用此方法
    //viewController 是被push的控制器，可以设置它的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            
            //隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
            //判断控制器的类型
            if let vc = viewController as? WBBaseViewController {
                
                var title = "返回"
                //判断控制器的及数,只有一个子控制器的时候，显示栈底控制的标题
                if childViewControllers.count == 1 {
                    //title显示首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                    
                }
                
                //取出自定义的 navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent),  isBack:true)
                
            }
            
        }
        
        
        super.pushViewController(viewController, animated: true)
        
        
    }
    //POP 返回到上一级控制器
    @objc private func popToParent(){
        popViewController(animated: true)
        
    }
    
    
}
