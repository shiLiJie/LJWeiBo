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
//        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 200
        // 设置表格自动计算行高
//        tableView.rowHeight = UITableViewAutomaticDimension
        // 取消分割线
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.None
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

}
