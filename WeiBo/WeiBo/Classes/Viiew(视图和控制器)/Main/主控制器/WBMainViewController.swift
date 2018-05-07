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
    
    /// 用户需要登录通知
    let YWUserShouldLoginNotification = "YWUserShouldLoginNotification"
    
    /// 成功登录通知
    let YWuserLoginSuccessedNotification = "YWuserLoginSuccessedNotification"
    
    @objc private func userLogin(noti:Notification){
        
        print("登录通知\(noti)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupComposeButton()
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: YWUserShouldLoginNotification), object: nil)
    }
    
    /// portrait  竖屏，肖像。  landscape 横屏 风景画
    //  使用代码控制设备的方向，好处，可以在需要横屏的时候，单独处理！
    //  设置支持的方向之后 当前的控制器及子控制器都会遵守这个方向！
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        return .portrait
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
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.yw_random()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
        
        
        
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
        //现在很多应用程序中，界面的创建都依赖网络的 json
        //默认的 json  。app发送请求，服务器返回新的配置json,例如 美团外卖的 520
        //配置文件保存在沙盒中。1，检查沙盒是否有josn 2. 加载默认的json.
        //3.如果存在就使用json设置界面。 可以做一些活动，如果沙盒有 优先用沙盒的
        let array: [[String:Any]] = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"home","visitorInfo" : ["imageName": "","message":"关注一些人，回这里看看有什么惊喜"]],
            ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center","visitorInfo" : ["imageName": "visitordiscover_image_message","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
            ["clsName":"UIViewcontroller"],
            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover","visitorInfo" : ["imageName": "visitordiscover_image_message","message":"登陆后，最新、最热的微博尽在掌握中，不会再于实事潮流擦肩而过"]],
            ["clsName":"WBProfileViewController","title":"我的","imageName":"profile","visitorInfo" : ["imageName": "visitordiscover_image_profile","message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
        ]
        
        //测试数据格式是否正确。 转换成plist 更加直观
        //(array as NSArray).write(toFile: "/Users/caihongguang/Desktop/demo.plist", atomically: true)
        
       //数组-》 json 序列化
        let data =   try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
        let fileURL = NSURL.fileURL(withPath: "/Users/caihongguang/Desktop/demo.json")
        (data as NSData).write(to: fileURL, atomically: true)
    
        
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        viewControllers = arrayM
        
        
    }
    private func controller(dict: [String: AnyObject]) -> UIViewController{
        //1.取得字典内容
        guard let title = dict["title"] as? String,
            let clsName = dict["clsName"] as? String,
            let imageName = dict["imageName"] as? String,
            //            //1> 将 clsName转换成 clbs
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as?[String: String]
            else
        {
            return UIViewController()
        }
        
        
        //2.创建视图控制器
        let vc = cls.init()
        
        vc.title = title
        
        //设置控制器访客信息字典
        vc.visitorInfoDic = visitorDict
        
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


