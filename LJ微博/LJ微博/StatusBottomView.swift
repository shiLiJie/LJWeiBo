//
//  StatusBottomView.swift
//  LJ微博
//
//  Created by slj on 15/10/19.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

class StatusBottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置UI
    private func setupUI() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        addSubview(forwardButton)
        addSubview(commentButton)
        addSubview(likeButton)
        
    //设置按钮的约束
        ff_HorizontalTile([forwardButton, commentButton, likeButton], insets: UIEdgeInsetsZero)
    }

    //懒加载控件
    private lazy var forwardButton: UIButton = UIButton(title: "转发", imageName: "timeline_icon_retweet")
    private lazy var commentButton: UIButton = UIButton(title: "评论", imageName: "timeline_icon_comment")
    private lazy var likeButton: UIButton = UIButton(title: "赞", imageName: "timeline_icon_unlike")

}
