//
//  BaseTableViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/7.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,VisitorLoginViewDelegate {

//    var loginon = false
    var loginon = UserAccount.userLogon
    var loginView: LoginView?
    override func loadView() {
        loginon ? super.loadView() : setView()
    }
    
    private func setView() {
        loginView = LoginView()
        loginView?.delegate = self
        view = loginView

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorLoginViewWillRegister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorLoginViewWillLogin")
        

    }
    
    func visitorLoginViewWillRegister() {
        print("注册")
    }
    func visitorLoginViewWillLogin() {
        let nav = UINavigationController(rootViewController: OAuthViewController())
        
        presentViewController(nav, animated: true, completion: nil)
        print("登录")
    }
}
