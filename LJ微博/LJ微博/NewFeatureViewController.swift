//
//  NewFeatureViewController.swift
//  LJ微博
//
//  Created by slj on 15/10/16.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
    
    private let imageCount = 4
    private let layout = LJFlowLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.collectionView!.registerClass(newFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }



    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! newFeatureCell
    
            cell.imageIndex = indexPath.item
    
        return cell
    }
    private func xitongcell() {
        
    }
    
    /// 完成显示 cell - indexPath 是之前消失 cell 的 indexPath
    override  func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        // 获取当前显示的 indexPath
        let path = collectionView.indexPathsForVisibleItems().last!
        
        // 判断是否是末尾的 indexPath
        if path.item == imageCount - 1{
            // 播放动画
            let cell = collectionView.cellForItemAtIndexPath(path) as! newFeatureCell
            cell.startButtonAnim()
        }
    }
 
}

/// 自定义cell 的类
class newFeatureCell: UICollectionViewCell {
    //设置属性
    private var imageIndex: Int = 0 {
        
        didSet{
            iconView.image = UIImage(named:"new_feature_\(imageIndex + 1)")
            startButton.hidden = true
        }
    }
    /// 按钮点击事件
    func clickStartButton() {
        print("123")
        NSNotificationCenter.defaultCenter().postNotificationName(SLJSwitchVCID, object: true)    }
    
    /// 开始按钮动画
    private func startButtonAnim() {
        startButton.hidden = false
        //开始按钮大小设为0
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        //禁用按钮操作
        startButton.userInteractionEnabled = false
        

        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 恢复默认形变
            self.startButton.transform = CGAffineTransformIdentity
            
            }) { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        }
        
    }
    //设置UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        prepareUI()
    }
        
        //添加控件
    private func prepareUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview": iconView]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview": iconView]))
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -160))
        startButton.addTarget(self, action: "clickStartButton", forControlEvents: UIControlEvents.TouchUpInside)

    }
        //懒加载控件
        private lazy var iconView = UIImageView()
        
        private lazy var startButton: UIButton = {
            
            let button = UIButton()
            button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
            button.setTitle("开始体验", forState: UIControlState.Normal)
            // 根据背景图片自动调整大小
            button.sizeToFit()
            
            return button
            }()

    }

    //设置流水布局
    /// 自定义流水布局, collectionview 必须写这个,不写就崩比的了
    private class LJFlowLayout: UICollectionViewFlowLayout {
        // 2. 如果还没有设置 layout，获取数量之后，准备cell之前，会被调用一次
        // 准备布局属性
        private override func prepareLayout() {
            itemSize = collectionView!.bounds.size
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            scrollDirection = UICollectionViewScrollDirection.Horizontal
            
            collectionView?.pagingEnabled = true
            collectionView?.showsHorizontalScrollIndicator = false
            collectionView?.bounces = false

    }
}
    

        