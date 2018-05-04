//
//  WBHomeViewController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    //显示好友
    @objc private func showFriends(){
        print(#function)
        
        let vc = WBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //重写父类的方法
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        
    }
    
}









