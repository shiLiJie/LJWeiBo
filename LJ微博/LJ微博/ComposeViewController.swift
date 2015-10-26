//
//  ComposeViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/26.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    //监听方法
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func sendStatus() {
        print("fasong")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        title = "发布微博"
        prepareNav()
        //        navigationItem.leftBarButtonItem?.title = "取消"
        //        navigationItem.rightBarButtonItem?.title = "发布"
    }
    
    private func prepareNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Plain, target: self, action: "sendStatus")
    }
}
