//
//  WBNetworkManger.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/9.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit
import AFNetworking

//网络管理工具
class WBNetworkManger: AFHTTPSessionManager {

    //静态区 / 常量 / 闭包
    //在第一次访问时，执行闭包，并在将结果保存在 shared常量中
    static let shared = WBNetworkManger()
    
    
    
    
    
}
