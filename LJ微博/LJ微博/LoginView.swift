//
//  LoginView.swift
//  LJ微博
//
//  Created by slj on 15/10/8.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit
protocol VisitorLoginViewDelegate: NSObjectProtocol{
    //将要登录
    func visitorLoginViewWillRegister()
    //将要注册
    func visitorLoginViewWillLogin()

    
    
}

/// 访客视图
class LoginView: UIView {
    /// 定义代理 -- 一定要用weak
    weak var delegate: VisitorLoginViewDelegate?
    
    /// 按钮监听方法
    func clickLogin() {
        
        delegate?.visitorLoginViewWillLogin()
    }
    func clickRegister() {
        delegate?.visitorLoginViewWillRegister()
    }
    
    // MARK: - 设置视图信息
    func setupInfo(ishome: Bool, imageName: String, message: String) {
    
        messageLabel.text = message
        iconView.image = UIImage(named: imageName);
        homeView.hidden = !ishome
        !ishome ? sendSubviewToBack(maskiconView) : startAnimation()
    }
    
    /// 开始动画
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 1 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        // 提示：如果界面上有动画，一定要检查退出到桌面再进入动画是否还在！
        anim.removedOnCompletion = false
        
        iconView.layer.addAnimation(anim, forKey: nil)
    }

// MARK: - 界面初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    

    required init?(coder aDecoder: NSCoder) {
//        禁止用sb / xib 使用本类
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        setupUI()
    }
    //设置界面,添加控件
    func setupUI() {
        backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        addSubview(iconView)
        addSubview(maskiconView)
        addSubview(homeView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
//      小圆圈的自动布局
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
//        遮罩灰色半屏幕视图的自动布局
        maskiconView.translatesAutoresizingMaskIntoConstraints = false
        
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[maskView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["maskView": maskiconView]))
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[maskView]-(-50)-[loginButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["maskView": maskiconView,"loginButton":loginButton]))

//        小房子的自动布局
        homeView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        
//        文本条消息框的自动布局
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))
//        如果文字比较多,这里可以设置宽度布局,弄的比较宽
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 225))
        
//        注册按钮的自动布局
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80))

//         登录按钮的自动布局
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80))




    }
    
//懒加载控件
    /// 图标
    lazy private var iconView:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
        
    }()
    /// 小房子
    lazy private var homeView:UIImageView = {
        let hv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return hv
    }()
    /// 消息
    lazy private var messageLabel:UILabel = {
        let mb = UILabel()
        mb.text = "关注一下,会有惊喜哟!"
        mb.textColor = UIColor.darkGrayColor()
//        numberoflines = 0 就是可以换行
        mb.numberOfLines = 0
        mb.textAlignment = NSTextAlignment.Center
        mb.sizeToFit()
        return mb
    }()
    /// 注册按钮
    lazy private var registerButton:UIButton = {
        let rb = UIButton()
        rb.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        rb.setTitle("注册", forState: UIControlState.Normal)
        rb.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        return rb
    }()
    /// 登录按钮懒加载
    lazy private var loginButton:UIButton = {
        let lb = UIButton()
        lb.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        lb.setTitle("登录", forState: UIControlState.Normal)
        lb.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        lb.addTarget(self, action: "clickLogin", forControlEvents: UIControlEvents.TouchUpInside)
        return lb
    }()
    
    /// 懒加载遮罩
    private lazy var maskiconView: UIImageView = {
        let mv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return mv
        }()
    

    
    
}