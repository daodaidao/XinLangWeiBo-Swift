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
        setupComposeButton()
    }
    
    
    //MARK: - 监听方法
    //撰写微博
    // FIXME: 没有实现
    // private 方法私有，仅在当前方法对象被访问
    //@obj 修饰符 能够保证用OC的方式访问。
    //@obj 允许这个函数在运行时 通过 OC的消息机制被调用。oc的写在.m里通过运行时也可以拿得到
    // oc一般好习惯都是写.m里，swift里用private修饰下
    @objc private func composeStatus() {
        print("撰写微博")
    }
    
    //MARK: - 私有控件
    // 撰写按钮
    private lazy var composeButton: UIButton = UIButton.yw_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
   
}

// extension 类似于 OC中的分类，在Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension中
// 便于代码维护
// 注意： 和 OC 的分类一样，extension中不能定义属性

// MARK: - 设置页面
extension WBMainViewController{
    
    //设置撰写按钮
    private func setupComposeButton(){
        tabBar.addSubview(composeButton)
        
        //计算按钮的宽度
        let count = CGFloat(childViewControllers.count)
        
        //将向内缩进的宽度减少，能够让按钮的宽度变大，  把容错点挡住 - 1。防止穿帮， 出现空白的UIViewController
        let w = tabBar.bounds.width / count-1
        
        //CGRectInset 正数向内缩进，负数向内扩展
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        //按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
        
    }
    
    //设置所有子控制器
    private func setupChildControllers(){
        
        let array = [
            ["clsName":"WBHomeViewController","title":"首页", "imageName":"home"],
            ["clsName":"WBMessageViewController","title":"消息", "imageName":"message_center"],
            
            ["clsName" : "UIViewController"],
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
        //4.设置 tabbar的标题字体
        
        //设置颜色没有效果
        //  vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for:.highlighted)
        //        //修改字体 系统默认是12号
        vc.tabBarItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize: 14)], for: .normal)

        let nav = WBNavigationController(rootViewController: vc)
        
        return nav
        
    }
    
    
}


