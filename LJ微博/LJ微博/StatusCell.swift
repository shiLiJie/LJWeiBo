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
        
        }
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

        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        // 2. 设置布局
    
        
//    / 设置布局约束
//        设置顶部约束
        topView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 53))
        
        //设置文本框约束
        contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPointMake(8, 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: -16))
        
        
//        bottomView.ff_AlignInner(type: ff_AlignType.BottomLeft, referView: contentView, size: nil)
        //设置底部约束
//        bottomView.frame = CGRectMake(100, 0, 375, 44)
        bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: UIScreen.mainScreen().bounds.size.width - 16, height: 44))
        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        
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
/// 底部视图
     lazy var bottomView:StatusBottomView = StatusBottomView()

}
