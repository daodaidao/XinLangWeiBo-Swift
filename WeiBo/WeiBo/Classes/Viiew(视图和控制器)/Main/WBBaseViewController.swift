//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    //自定义导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.yw_screenWidth(), height: UIScreen.yw_screenHeight()))
    //自定义的导航项条目
    lazy var navItem = UINavigationItem()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
        
    }
    //重写 title的didSet
    override var title:String?{
        didSet {
            navItem.title = title
        }
    }
    
    
    func setupUI(){
        view.backgroundColor = UIColor.yw_random()
        
        //添加导航条
        view.addSubview(navigationBar)
        //将 item 设置给 bar
        navigationBar.items = [navItem]
        
        
    }
    
}



 






