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

    //访问令牌，所有网络请求，都基于此令牌（登录除外）
    var accessToken: String? = "2.006FpknD_yaRiCdbdbb1f632Lx79wB"
    
    //专门负责拼接 token的网络请求方法
    func tokenRequest(method: WBHTTPMethod = .GET, URLString: String, parameters: [String:AnyObject]?, completion: @escaping (_ json: AnyObject?,_ isSuccess: Bool) ->Void){
        
        //处理 token 字典
        
        //处理 token 字典 程序执行过程中 一般 token 不会为nil
        guard let token = accessToken else {
            //没有token 需要重新登录
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: YWUserShouldLoginNotification), object: nil, userInfo: nil)
             completion(nil, false)
            return
        }
        
        var parameters = parameters
        
        if parameters == nil {
            //实例化字典
            parameters = [String: AnyObject]()
        }
        
        //设置参数字典,代码在此一定不会为nil
        parameters!["access_token"] = token as AnyObject?
        
        
        //判断name 和 data
//        if let name = name ,
//            let data = data{
//            //上传文件
//            upLoad(URLString: URLString, name: name, data: data, parameters: parameters, completion: completion)
//        }else{
            //调用 request 发起真正的网络请求
            request(method: method, URLString: URLString, parameters: parameters, completion: completion)
//        }
        
        
    
        
        
    }
    
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
