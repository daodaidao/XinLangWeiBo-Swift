//
//  AppDelegate.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        sleep(2)
        window = UIWindow()
        window?.backgroundColor  = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        loadAppInfo()
        
        return true
    }
    
}


// MARK: - 从服务器加载应用程序信息
extension AppDelegate {
    
    private func loadAppInfo(){
        
        //1.模拟异步
        DispatchQueue.global().async {
            
            //1> url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            //2> data
            let data = NSData(contentsOf: url!)
            
            //3> 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕 \(jsonPath)")
            
            
            
            
            
            
            
        }
        
    }
    
}



extension AppDelegate {
    
    fileprivate func steupAdditions() {
        //1.设置 SVP 的最下接触时间
        //        SVProgressHUD.setMinimumDismissTimeInterval(1)
        //        //2.设置网络加载指示器
        //        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        //3.设置用户授权显示通知
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound,.carPlay ]) { (success, error) in
                print("用户授权显示通知" + (success ? "成功" : "失败"))
            }
        } else {
            //10.0之前旧版本  获取用户授权显示通知（上方的提示条、声音、BadgeNumber）
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
        }
    }
    
}





