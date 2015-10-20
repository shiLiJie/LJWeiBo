//
//  StatusTopView.swift
//  LJ微博
//
//  Created by slj on 15/10/19.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit
import SDWebImage

/// 微博cell顶部的视图
class StatusTopView: UIView {
    /// 微博数据模型
    var status: Status? {
        didSet {
        if let url = status?.user?.imageURL {
            iconView.sd_setImageWithURL(url)
            }
            nameLabel.text = status?.user?.name ?? ""
            vipIconView.image = status?.user?.vipImage
            memberIconView.image = status?.user?.memberImage
            
            // TODO: 后面会讲
            timeLabel.text = "刚刚"
            sourceLabel.text = "来自 微博.com"
        }
    }
    
    //设置UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //搭建界面
    private func setupUI() {
        //添加顶部部分视图
        let sepView = UIView()
        sepView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        addSubview(sepView)
        sepView.ff_AlignVertical(type: ff_AlignType.TopLeft, referView: self, size: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 10))
        
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        
        //设置布局约束
        // 2. 设置布局
        iconView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: sepView, size: CGSize(width: 35, height: 35), offset: CGPoint(x: 8, y: 8))
        
        nameLabel.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        timeLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        sourceLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: timeLabel, size: nil, offset: CGPoint(x: 12, y: 0))
        memberIconView.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: nameLabel, size: nil, offset: CGPoint(x: 12, y: 0))
        vipIconView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 8))

        
    }
    //懒加载控件
    // 1. 头像图标
    private lazy var iconView: UIImageView = UIImageView()
    // 2. 姓名
    private lazy var nameLabel: UILabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14)
    // 3. 时间标签
    private lazy var timeLabel: UILabel = UILabel(color: UIColor.orangeColor(), fontSize: 9)
    // 4. 来源标签
    private lazy var sourceLabel: UILabel = UILabel(color: UIColor.lightGrayColor(), fontSize: 9)
    // 5. 会员图标
    private lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    // 6. vip图标
    private lazy var vipIconView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    

}
