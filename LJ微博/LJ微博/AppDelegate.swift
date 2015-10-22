//
//  AppDelegate.swift
//  LJ微博
//
//  Created by slj on 15/10/7.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit
/// 在类的外面写的常量或者变量就是全局能够访问的
/// 视图控制器切换通知字符串
let SLJSwitchVCID = "SLJSwitchVCID"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupAppearance()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchViewControllor:", name: SLJSwitchVCID, object: nil)
        
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = defaultVC()
        
        window?.makeKeyAndVisible()
                
        
        
        return true
    }
    /// 返回启动默认的控制器
    func switchViewControllor(n: NSNotification) {
        let mainVc = n.object as! Bool
        window?.rootViewController =  mainVc ? MainViewController() : WelcomeViewController()
    }
    
    func defaultVC() -> UIViewController {
        // 1. 判断用户是否登录，如果没有登录返回主控制器
        if !UserAccount.userLogon {
            return MainViewController()
        }
        // 2. 判断是否新版本，如果是，返回新特性，否则返回欢迎
        return isNewUpdate() ? NewFeatureViewController() : WelcomeViewController()

    }
    /// 检查是否有新版本
    private func isNewUpdate() -> Bool {
        // 1. 获取程序当前的版本
        let currentVersion = Double(NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String)!
        
        // 2. 获取程序`之前`的版本，偏好设置
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(sandboxVersionKey)
        
        // 3. 将当前版本保存到偏好设置
        NSUserDefaults.standardUserDefaults().setDouble(currentVersion, forKey: sandboxVersionKey)
        // iOS 7.0 之后，就不需要同步了，iOS 6.0 之前，如果不同步不会第一时间写入沙盒
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // 4. 返回比较结果
        return currentVersion > sandboxVersion
    }

    
/// 设置全局外观
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }

}

