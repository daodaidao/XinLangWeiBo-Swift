//
//  WBDemoViewController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/4.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置标题
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    
    /// 继续push一个新的控制器
    @objc private func showNext(){
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    //重写父类的方法
    override func setupUI() {
        super.setupUI()
        //设置右侧控制器
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(showNext))
        
        let btn : UIButton = UIButton.yw_textButton("下一个", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    
    
}






