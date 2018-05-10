//
//  WBNetworkManger.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/9.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit
import AFNetworking

//swift 的  枚举和 switch 在oc都只是支持整数，swift支持任意类型
enum WBHTTPMethod {
    case GET
    case POST
}

//网络管理工具
class WBNetworkManger: AFHTTPSessionManager {
    
    //静态区 / 常量 / 闭包
    //在第一次访问时，执行闭包，并在将结果保存在 shared常量中
    static let shared = WBNetworkManger()
    //使用一个函数封装AFN的get和post请求
    /// 封装AFN 的的GET /POST请求
    ///
    /// - parameter method:     GET /POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter completion: 回调json、是否成功
    func request(method: WBHTTPMethod = .GET, URLString: String, parameters: [String:AnyObject]?, completion: @escaping (_ json: AnyObject?,_ isSuccess: Bool) ->Void) {
        
        //成功回调
        let success = {(task: URLSessionDataTask, json: Any?) ->() in
            completion(json as AnyObject?, true)
        }
        //失败回调
        let failure = {(task: URLSessionDataTask?, error: Error) ->() in
            
            //针对 403 处理token 过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YWUserShouldLoginNotification), object: "bad Token", userInfo: nil)
            }
            print("网络请求错误\(error)")
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
    
    
}
