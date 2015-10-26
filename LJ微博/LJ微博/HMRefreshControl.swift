//
//  HMRefreshControl.swift
//  LJ微博
//
//  Created by slj on 15/10/22.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

private let kRefreshPullOffset: CGFloat = -60


class HMRefreshControl: UIRefreshControl {
    
    // MARK: - 重写结束刷新方法
    override func endRefreshing() {
    super.endRefreshing()
    
    refreshView.stopLoading()
    }
    
    // MARK: - KVO
    /**
    向下拉表格，y 值越来越小
    向上推表格，y 值越来越大
    从表格顶部向下拉，y值是负数
    拽到一定幅度，会自动进入刷新状态
    */
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
    // 如果y > 0 直接返回
    if frame.origin.y > 0 {
    return
    }
    
    // 判断是否开始刷新，如果进入刷新状态，播放加载动画
    if refreshing {
    refreshView.startLoading()
    }
    
    if frame.origin.y < kRefreshPullOffset && !refreshView.rotateFlag {
    print("翻过来")
    refreshView.rotateFlag = true
    } else if frame.origin.y > kRefreshPullOffset && refreshView.rotateFlag {
    print("转过去")
    refreshView.rotateFlag = false
    }
    }
    
    // MARK: - 构造函数
    override init() {
    super.init()
    
    setupUI()
    }
    
    /// 从 xib ／ sb 加载视图之后，做额外的设置
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    self.removeObserver(self, forKeyPath: "frame")
    }
    
    private func setupUI() {
    // KVO 监听 frame 属性变化
    self.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions(rawValue: 0), context: nil)
    
    // 隐藏默认的转轮
    tintColor = UIColor.clearColor()
    
    // 添加刷新视图
    addSubview(refreshView)
    
    // 自动布局 - 从 xib 加载的时候，可以直接取到真实的大小
    refreshView.ff_AlignInner(type: ff_AlignType.CenterCenter, referView: self, size: refreshView.bounds.size)
    }
    
    // MARK: － 懒加载控件
    private lazy var refreshView: HMRefreshView = HMRefreshView.refreshView()
    
}
    

class HMRefreshView: UIView {
    
    /// 旋转标记
    private var rotateFlag = false {
        didSet {
            rotateTipIcon()
        }
    }
    
    /// 加载图标
    @IBOutlet weak var loadIcon: UIImageView!
    /// 提示视图
    @IBOutlet weak var tipView: UIView!
    /// 提示图标
    @IBOutlet weak var tipIcon: UIImageView!
    
    /// 从 xib 加载刷新视图
    class func refreshView() -> HMRefreshView {
        return NSBundle.mainBundle().loadNibNamed("HMRefreshView", owner: nil, options: nil).last as! HMRefreshView
    }
    /// 提示图标的旋转
    private func rotateTipIcon() {
        // 在块代码动画中，旋转会就近原则，默认顺时针寻找方向
        let angle = rotateFlag ? CGFloat(M_PI - 0.01) : CGFloat(M_PI + 0.01)
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.tipIcon.transform = CGAffineTransformRotate(self.tipIcon.transform, angle)
        }
    }
    
    private func startLoading() {
        if loadIcon.layer.animationForKey("loadingAnima") != nil {
        return
        }
        
        //隐藏提示视图
        tipView.hidden = true
        
        //定义动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 1.0
        
        //添加动画
        tipView.layer.addAnimation(anim, forKey: "loadingAnima")
    }
    
    //停止加载动画
    private func stopLoading() {
        tipView.hidden = false
        loadIcon.layer.removeAllAnimations()
    }
}
