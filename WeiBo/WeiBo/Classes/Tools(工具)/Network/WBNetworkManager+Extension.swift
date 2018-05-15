//
//  WBNetworkManager+Extension.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/10.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import Foundation

//MARK: - 封装新浪微博的网络请求方法
extension WBNetworkManger {
    
    /// - parameter since_id:   返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    /// - parameter max_id:     返回ID小于或等于max_id的微博，默认为0
    /// - parameter completion: 完成回调
    func statusList(completion: @escaping (_ list:[[String: AnyObject]]?,_ isSuccess: Bool)->()) {
        
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
      
        tokenRequest(URLString: urlStr, parameters: nil as [String : AnyObject]?) { (json, isSuccess) in
            //从json 中获取 statues 字典数组  如果 as？ 失败 result = nil
            let result = json?["statuses"] as? [[String:AnyObject]]
            print("加载数据成功:\(result)")
            completion(result, isSuccess)
        }
    }
  
    
}











