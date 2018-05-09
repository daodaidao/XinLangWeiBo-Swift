//
//  WBHomeViewController.swift
//  WeiBo
//
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit

//定义全局常量，尽量使用 private 修饰，否则到处都可以访问
private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {
    
    // 微博数据数组
    lazy private var statusList = [String]()
    //加载数据
    override func loadData() {
        
        print("开始加载数据\(WBNetworkManger.shared)")
        
        //模拟 延时 加载数据
        //延时1秒执行
        let time: TimeInterval = 1.0
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            print("1 秒后输出")
            
            for i in 0..<15 {
                if self.isPullup {
                    //将数据追加到底部
                    self.statusList.append("上拉\(i)")
                }
                
                //将数据插入到数组顶部
            self.statusList.insert(i.description, at: 0)
            }
            //结束刷新控件
            self.refreshControl?.endRefreshing()
            //恢复上拉刷新标记
            self.isPullup = false
            //刷新表格
            self.tableView?.reloadData()
            
            
            
            
        }
        
        
        
    }
    
    
    //显示好友
    @objc private func showFriends(){
        print(#function)
        
        let vc = WBDemoViewController()
        
        // push 的动作是 nav做的
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //重写父类的方法
    
    
    override func setupTableView() {
        
        super.setupTableView()
        //设置导航栏按钮
        //无法高亮
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        //自定义导航栏按钮 加高亮颜色
        //Swift 调用 OC返回 instancetype的方法，判断不出是否可选，加个UIButton类型就不用解包了
        //        let btn : UIButton = UIButton.yw_textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        //        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
}

// MARK: - 表格数据源方法,具体的数据源方法实现，不需要  super
extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for:indexPath)
        
        cell.textLabel?.text = statusList[indexPath.row]
        
        return cell
    }
    
    
}









