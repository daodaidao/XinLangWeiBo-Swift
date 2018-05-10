//
//  WBStatus.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/10.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit
import YYModel

//微博数据模型
class WBStatus: NSObject {
    
    // Int 类型，在 64位 机器 64位，32位机器是32
    // 如果不写 Int64 在 iPad 2/iPhone 5/5c /4s/4 都无法正常运行
    var id: Int64 = 0
    //微博信息内容
    var text: String?
    
    //重写 description的计算型属性
    override var description: String {
        
        return yy_modelDescription()
    }
    

}
