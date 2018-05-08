//
//  WBBaseViewController.swift
//  WeiBo
// http://www.wufangbo.com/8292/ 导航和状态栏错位适配
//  Created by caihongguang on 2018/5/3.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import UIKit
// swift里用,号 类似于多继承  ，oc中不支持多继承，答案使用协议。
//class WBBaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

class WBBaseViewController: UIViewController {
    
    //MARK: - 全局通知定义
    /// 用户需要登录通知
    let YWUserShouldLoginNotification = "YWUserShouldLoginNotification"
    
    /// 成功登录通知
    let YWuserLoginSuccessedNotification = "YWuserLoginSuccessedNotification"

    
    //用户是否登录
    var userLogin = false
    
    //访客视图信息字典
    var visitorInfoDic :[String:String]?
    //表格视图-如果用户没有登录就创建
    var tableView: UITableView?
    //刷新控件
    var refreshControl:UIRefreshControl?
    //上拉刷新标记
    var isPullup  = false
    
    
    //自定义导航栏 44是没有适配iPhone X的
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.yw_screenWidth(), height: 44))
    //自定义的导航项条目 
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
        loadData()
    }
    
    //重写 title的didSet
    override var title:String?{
        didSet {
            navItem.title = title
        }
    }
    
    @objc func loadData(){
        //子类去重写
        //如果子类不实现任何方法，默认关闭刷新控件，主程设计的时候要考虑全面性
        refreshControl?.endRefreshing()
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor.white
        
        
        //nav和scrollview 要进行缩进的调整
        
        //如果隐藏了导航栏会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        
        //代码顺序如果都要注意就太累了，在下面插入下就可以了
        setupNavigationBar()
        userLogin ? setupTableView() : setupVisitorView()
 
    }
    
    private func setupVisitorView(){
        
        let visitorView = WBVisitorView(frame: view.bounds)
//        visitorView.backgroundColor = UIColor.yw_random()
      
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        visitorView.visitorInfo = visitorInfoDic
        
        //添加访客视图按钮的监听方法
        visitorView.loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
        
    }
    
    //设置表格视图
    //子类重写此方法，因为子类不需要关心用户登录之前的逻辑
    func setupTableView () {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        //设置数据源和代理，目的 ： 子类直接实现数据方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        //设置内容缩进(不用修改tableview的y坐标)
        //配合上面缩进的时候用 automaticallyAdjustsScrollViewInsets
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49 , right: 0)
        
        //设置刷新控件
        //1 实例化控件
        refreshControl = UIRefreshControl()
        //2.添加表格视图
        tableView?.addSubview(refreshControl!)
        //3. 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        
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
    
    @objc fileprivate func login() {
        
        print("用户登录")
        //发送通知
//        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: YWUserShouldLoginNotification), object: nil, userInfo: nil))
    }
    
    @objc fileprivate func register() {
        
        print("用户注册")
    }
    
}
//在swift中利用 extension可以把 函数按照功能分类管理，便于阅读和维护
//注意：1.extension不能有属性 2.不能重写父类方法！重写父类方法是子类的职责。扩展是对类的扩展
extension WBBaseViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    //基类只是准备方法，子类负责具体的实现
    //子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //在显示最后一行的时候做上拉刷新
    //willDisplay 做无缝上拉加载更多
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1.判断indexPath 是否是最后一行(indexPath.section(最大)/row最后一昂)
        //1> row
        let row = indexPath.row
        //2>section
        let section = tableView.numberOfSections - 1
        print(section)
        
        if row < 0 || section < 0 {
            return
        }
        //3.行数
        let count = tableView.numberOfRows(inSection: section)
        
        //如果是最后一行，同时没有开始上拉刷新
        if row == (count - 1) && !isPullup{
            print("上拉刷新")
            isPullup = true
            //开始刷新
            loadData()
        }
        
        
    }
    
}




