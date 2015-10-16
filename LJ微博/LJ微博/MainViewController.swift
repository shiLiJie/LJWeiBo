//
//  MainViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/7.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    setChileView()
        
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupComposedButton()
    }
    
    //设置按钮和按钮的位置
    private func setupComposedButton() {
        let w = tabBar.bounds.width / CGFloat(viewControllers!.count)
        
        let rect = CGRect(x: 0, y: 0, width: w, height: tabBar.bounds.height)
        poseButton.frame = CGRectOffset(rect, 2 * w, 0)
        
    }

     func clickComposedButton() {
        print(__FUNCTION__)
    }
    
    //添加所有控制器
    private func setChileView(){
        setChildView(HomeViewController(), title: "首页", imageName: "tabbar_home")
        setChildView(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(UIViewController())
        setChildView(DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        setChildView(ProfileViewController(), title: "我", imageName: "tabbar_profile")
        
    }
    
    //添加子控制器
    private func setChildView(vc:UIViewController,title:String,imageName:String){
        
//        let vc = HomeViewController()
        
        tabBar.tintColor = UIColor.orangeColor()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        //设置navgation控制器为子控制器
        let nav = UINavigationController(rootViewController: vc)
        
        addChildViewController(nav)
    }
    
    //懒加载生成按钮
    lazy private var poseButton: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        self.tabBar.addSubview(button)
        button.addTarget(self, action: "clickComposedButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
        
    }()
    

}
