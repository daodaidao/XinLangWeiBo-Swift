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
        
        // push 的动作是 nav做的
    navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //重写父类的方法
    override func setupUI() {
        super.setupUI()
        
        //设置导航栏按钮
        //无法高亮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        //自定义导航栏按钮 加高亮颜色
        //Swift 调用 OC返回 instancetype的方法，判断不出是否可选，加个UIButton类型就不用解包了
//        let btn : UIButton = UIButton.yw_textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
    }
    
}









