//
//  AppDelegate.swift
//  LJ微博
//
//  Created by slj on 15/10/7.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

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
        
//        window?.rootViewController = defaultVC()
        window?.rootViewController = NewFeatureViewController()
        
        window?.makeKeyAndVisible()
                
        
        
        return true
    }
    
    func switchViewControllor(n: NSNotification) {
        let mainVc = n.object as! Bool
        window?.rootViewController =  mainVc ? MainViewController() : WelcomeViewController()
    }
    
    func defaultVC() -> UIViewController {
        if UserAccount.userLogon {
            return WelcomeViewController()
        }else {
            return MainViewController()
        }
    }
    
    
/// 设置全局外观
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }

}

