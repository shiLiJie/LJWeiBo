//
//  WelcomeViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/15.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    /// 图像底部约束
    private var iconBottomCons: NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        //加载用户头像
        if let urlString = UserAccount.sharedAccount?.avatar_large {
            iconView.sd_setImageWithURL(NSURL(string: urlString))
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 提示：修改约束不会立即生效，添加了一个标记，统一由自动布局系统更新约束
        iconBottomCons?.constant = UIScreen.mainScreen().bounds.height - iconBottomCons!.constant
        
        // 动画
        UIView.animateWithDuration(1.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            // 强制更新约束
            self.view.layoutIfNeeded()
            
            
            }) { (_) -> Void in
                //这里接收 appdelegate 里发过来的通知,调用方法判断是否切换控制器
             NSNotificationCenter.defaultCenter().postNotificationName(SLJSwitchVCID, object: true)
                
        }
    }

    
    private func prepareUI() {
        view.addSubview(backImageView)
        view.addSubview(iconView)
        view.addSubview(label)

    // 自动布局
    // 1> 背景图片
    backImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview": backImageView]))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview": backImageView]))
    
    // 2> 头像
    iconView.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 90))
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 90))
    view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 160))
    // 记录底边约束
    iconBottomCons = view.constraints.last
    
    // 3> 标签
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))

    }
    //懒加载控件
    /// 懒加载背景图片
    private lazy var backImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    /// 懒加载头像
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 45
        return iv
    }()
    /// 懒加载欢迎归来文本框
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "欢迎归来"
        label.sizeToFit()
        return label
    }()
}
