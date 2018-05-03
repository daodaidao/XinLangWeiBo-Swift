//
//  WBMainViewController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

//主控制器
class WBMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
    }
    
}

// extension 类似于 OC中的分类，在Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension中
// 便于代码维护
// 注意： 和 OC 的分类一样，extension中不能定义属性

// MARK: - 设置页面
extension WBMainViewController{
    //设置所有子控制器
    private func setupChildControllers(){

        let array = [
            ["clsName":"WBHomeViewController","title":"首页", "imageName":"home"],
            ["clsName":"WBMessageViewController","title":"消息", "imageName":"message_center"],

            ["clsName":"WBDiscoverViewController","title":"发现", "imageName":"discover"],

            ["clsName":"WBProfileViewController","title":"我", "imageName":"profile"],

            
            ]
        
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
        
        
    }
    private func controller(dict: [String: String]) -> UIViewController{
        //1.取得字典内容
        guard let title = dict["title"],
            let clsName = dict["clsName"],
            let imageName = dict["imageName"],
            //            //1> 将 clsName转换成 clbs
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseViewController.Type
            else
        {
            return UIViewController()
        }
        
        
        //2.创建视图控制器
        let vc = cls.init()
    
        vc.title = title
        
        //3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        
        let nav = WBNavigationController(rootViewController: vc)
        
        return nav

    }
    
    
}


