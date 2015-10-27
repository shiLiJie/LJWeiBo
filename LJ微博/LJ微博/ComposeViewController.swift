//
//  ComposeViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/26.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    //左右按钮监听方法
    func close() {
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    func sendStatus() {
        print("fasong")
    }
    func inputEmoticon() {
        print("加入表情")
    }
    
    override func viewDidLoad() {
        addKeyboardOberserver()
    }
    deinit {
        removeKeyboardOberserber()
    }
    
    /// 添加键盘通知
    private func addKeyboardOberserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChanged:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    /// 移除键盘通知
    private func removeKeyboardOberserber() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /// toolbar 底部约束
    private var toolbarBottomCons: NSLayoutConstraint?
    /// 键盘变化的监听方法
    func keyboardChanged(n: NSNotification) {
        // 获取目标 frame
        let rect = n.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        // 动画时长
        let duration = n.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        // 设置约束
        toolbarBottomCons?.constant = -(UIScreen.mainScreen().bounds.height - rect.origin.y)
        //动画
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    /// 把键盘设置成第一响应者,进来就有键盘
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()

        prepareNav()
        prepareToolbar()
        prepareTextView()
    }
/// 准备文本框
    private func prepareTextView() {
        view.addSubview(textView)

        textView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        textView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: view, size: nil)

        textView.ff_AlignVertical(type: ff_AlignType.TopRight, referView: toolBar, size: nil)

        // 添加占位标签
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: textView, size: nil, offset: CGPoint(x: 5, y: 8))
    }
    
    
    /// 准备toolbar
    private func prepareToolbar() {
        
        toolBar.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        view.addSubview(toolBar)
        
        let cons = toolBar.ff_AlignInner(type: ff_AlignType.BottomLeft, referView: view, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 44))
        //记录底部约束
        toolbarBottomCons = toolBar.ff_Constraint(cons, attribute: NSLayoutAttribute.Bottom)
        
        //定义toolbar按钮的数组,把图片都放进去
        // 定义一个数组
        let itemSettings = [["imageName": "compose_toolbar_picture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background", "action": "inputEmoticon"],
            ["imageName": "compose_addbutton_background"]]
        
        var items = [UIBarButtonItem]()
        
        for dict in itemSettings {

            items.append(UIBarButtonItem(imageName: dict["imageName"]!, target: self, action: dict["action"]))
            
            //追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil))
        }
        //移除最后一个
        items.removeLast()
        
        toolBar.items = items
        
    }
    
    
/// 设置发布微博顶部导航栏内容
    private func prepareNav() {
        //导航栏左右按钮设置
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Plain, target: self, action: "sendStatus")
        navigationItem.rightBarButtonItem?.enabled = false
        
        //设置顶部中间位置的文本框视图,上下两层实现
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
//        titleView.backgroundColor = UIColor.blackColor()
        
        let titleLabel = UILabel(color: UIColor.blackColor(), fontSize: 15)
        titleLabel.text = "发微博"
        titleLabel.sizeToFit()
        titleView.addSubview(titleLabel)
        titleLabel.ff_AlignInner(type: ff_AlignType.TopCenter, referView: titleView, size: nil)

        
        let nameLabel = UILabel(color: UIColor.grayColor(), fontSize: 13)
        nameLabel.text = UserAccount.sharedAccount?.name ?? ""
        nameLabel.sizeToFit()
        titleView.addSubview(nameLabel)
        nameLabel.ff_AlignInner(type: ff_AlignType.BottomCenter, referView: titleView, size: nil)

        
        navigationItem.titleView = titleView
    }
    //懒加载控件
    private lazy var textView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFontOfSize(18)
        
        //允许垂直拖拽
        tv.alwaysBounceVertical = true
        //拖拽关闭键盘
        tv.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        return tv
    }()
    
    /// 占位标签
    private lazy var placeholderLabel = UILabel(color: UIColor.lightGrayColor(), fontSize: 18)
    /// 工具栏
    private lazy var toolBar = UIToolbar()
}



