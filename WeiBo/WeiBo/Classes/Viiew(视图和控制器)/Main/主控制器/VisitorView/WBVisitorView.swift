//
//  WBVisitorView.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/7.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    override init(frame:CGRect)
    {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: -设置页面
extension WBVisitorView {
    
    func setupUI(){
        backgroundColor = UIColor.white
    }
    
    
}









