//
//  AppDelegate.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

     
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        sleep(2)
        window = UIWindow()
        window?.backgroundColor  = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
 
        return true
    }

   

}

