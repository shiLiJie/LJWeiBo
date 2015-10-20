//
//  StatusCell.swift
//  LJ微博
//
//  Created by slj on 15/10/19.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    /// 微博模型数据
    var status: Status? {
        didSet {
            topView.status = status
            contentLabel.text = status?.text ?? ""
            //设置配图数据
            pictureView.status = status
            //设置配图尺寸
            pictureHeightCons?.constant = pictureView.bounds.height
            pictureWidthCons?.constant = pictureView.bounds.width
        }
    }
    /// 图片宽度约束
    var pictureWidthCons: NSLayoutConstraint?
    /// 图片高度约束
    var pictureHeightCons: NSLayoutConstraint?
    /// 计算行高
    func rowHeight(status: Status) -> CGFloat {
        // 设置属性
        self.status = status
        // 强行更新布局 － 所有的控件的frame都会发生变化
        // 使用自动布局，不要直接修改frame，修改的工作交给自动布局系统来完成
        layoutIfNeeded()
        // 返回底部视图的最大高度
        return CGRectGetMaxY(bottomView.frame)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
/// 添加控件
    private func setupUI() {
        contentView.addSubview(topView)
        contentView.addSubview(pictureView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        // 2. 设置布局
    
        
//    / 设置布局约束
//        设置顶部约束
        topView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 53))
        
        //设置文本框约束
        contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPointMake(8, 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: -16))
        // 3> 配图视图
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: 290, height: 290), offset: CGPoint(x: 0, y: 8))
        pictureWidthCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureHeightCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        

        //设置底部约束
        bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 44), offset: CGPoint(x: -8, y: 8))

        
    }

    
    //懒加载控件
 /// 顶部视图
    private lazy var topView: StatusTopView = StatusTopView()
/// 内容标签
    private lazy var contentLabel:UILabel = {
        let label = UILabel(color: UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines = 0
        return label
    }()
    private lazy var pictureView:StatusPictureView = StatusPictureView()
/// 底部视图
     lazy var bottomView:StatusBottomView = StatusBottomView()

}
