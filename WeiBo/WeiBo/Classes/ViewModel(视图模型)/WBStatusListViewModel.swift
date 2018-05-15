//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/10.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import Foundation

//微博数据列表视图模型
/// 父类的选择
// 如果类需要使用 KVC 或者字典转模型框架设置对象值，类就要继承自 NSObjecct
// 如果类只是包装一些代码逻辑，氪不用任何父类，好处：更加轻量级
//提示： 如果用oc写，一律都继承自 NSObject即可。

//使命：负责微博的数据处理
// 字典转模型
// 下拉/上拉刷新数据处理

class WBStatusListViewModel {
    //微博模型数组懒加载
    lazy var statusList =  [YWStatusViewModel]()
    
    func loadStatus(completion: @escaping (_ isSuccess: Bool)->()){
        
        WBNetworkManger.shared.statusList { (list, isSuccess) in
            
//            let array =  NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus]
//
//            print("array微博数据\(array)")
 
            
            //1.字典转模型
            var array = [YWStatusViewModel]()
            
            //遍历服务器返回字典数组，字典转模型
            
            for dic in list ?? [] {
                
                //创建微博模型 - 创建失败 继续遍历
                guard let model = WBStatus.yy_model(with: dic) else{
                    continue
                }
                //将视图模型添加到数组
                array.append(YWStatusViewModel(model: model))
            }
            
            self.statusList += array
            
            completion(isSuccess)

            
            
            
            
            
            
            
            //list是有值的，但是 字典转模型失败
            //1.字典转模型
//            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
//
//                completion(isSuccess)
//
//                return
//            }
//            //2.拼接数据
//            self.statusList += array
//            //3.完成回调
//            completion(isSuccess)
            
     
        }
   
    }
    
    
    
    
}
