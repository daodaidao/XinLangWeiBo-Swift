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
    
    //列表视图模型
    private lazy var listViewModel = WBStatusListViewModel()
    
    //加载数据
    override func loadData() {
        
        listViewModel.loadStatus { (isSuccess) in
            
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
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
}

// MARK: - 表格数据源方法,具体的数据源方法实现，不需要  super
extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for:indexPath)
        
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        return cell
    }
    
    
}









