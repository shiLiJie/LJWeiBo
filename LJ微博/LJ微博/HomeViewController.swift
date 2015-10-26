//
//  HomeViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/7.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
    
    /// 微博数据数组
    var statuses: [Status]? {
        didSet {
            // 刷新数据
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 如果用户没有登录，设置访客视图，返回
        if !UserAccount.userLogon {
        loginView?.setupInfo(true, imageName: "visitordiscover_feed_image_smallicon", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        prepareTableView()
        loadData()
    }
    /// 准备表格视图
    private func prepareTableView() {
        // 注册原型 cell
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: "Cell")
        // 设置表格的预估行高(方便表格提前计算预估行高，提高性能)
        tableView.estimatedRowHeight = 300
//        tableView.rowHeight = 200
        // 设置表格自动计算行高
//        tableView.rowHeight = UITableViewAutomaticDimension
        // 取消分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //添加刷新控制器
        refreshControl = HMRefreshControl()
        //添加监听方法
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    /// 加载数据
    private func loadData() {
        Status.loadStatus {[weak self] (dataList, error) -> () in
            if error != nil {
                print(error)
                return
            }
            
            self?.statuses = dataList
        }
    }
    
    // MARK: - 数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 要求必须注册原型cell, storyboard，register Class
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StatusCell
        
        cell.status = statuses![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //获取模型
        let status = statuses![indexPath.row]
        if let h = status.rowHeight {
            return h
        }
        // 2. 获取 cell - dequeueReusableCellWithIdentifier 带 indexPath 的函数会调用计算行高的方法
        // 会造成死循环，在不同版本的 Xcode 中 行高的计算次数不一样！尽量要优化！
        // 如果不做处理，会非常消耗性能！
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? StatusCell
        
        // 3. 记录并返回计算的行高
        status.rowHeight = cell!.rowHeight(status)
        
        return status.rowHeight!
        
    }

}
