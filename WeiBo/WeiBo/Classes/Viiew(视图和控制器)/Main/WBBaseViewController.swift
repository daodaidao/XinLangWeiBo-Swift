//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    //表格视图-如果用户没有登录就创建
    var tableView: UITableView?
    
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
       
        //代码顺序如果都要注意就太累了，在下面插入下就可以了

        setupNavigationBar()
        setupTableView()

    }
    
    private func setupTableView () {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
    }
    
    
    private func setupNavigationBar(){
        
        //添加导航条
        view.addSubview(navigationBar)
        
        //将 item 设置给 bar
        navigationBar.items = [navItem]
        //设置navbar渲染颜色 防止跳转的时候有白色
        navigationBar.barTintColor = UIColor.yw_color(withHex: 0xF6F6F6)
        
        //navBar字体颜色设置
        //        navigationBar.titleTextAttributes = [nsfore]
    }
    
}






