//
//  UIBarButtonItem+Extension.swift
//  我的微博
//
//  Created by teacher on 15/8/4.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 分类只能提供便利构造函数，便利构造函数中，需要调用 self.init()
    /// 创建 UIBarButtonItem
    ///
    /// :param: imageName 图像名
    /// :param: target    目标对象
    /// :param: action    调用方法名
    ///
    /// :returns: UIBarButtonItem
    convenience init(imageName: String, target: AnyObject?, action: String?) {
        let button = UIButton()
        
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        button.sizeToFit()
        
        // 设置监听方法，判断 action 是否存在
        if let actionName = action {
            button.addTarget(target, action: Selector(actionName), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        // 调用指定的构造函数
        self.init(customView: button)
    }
}
