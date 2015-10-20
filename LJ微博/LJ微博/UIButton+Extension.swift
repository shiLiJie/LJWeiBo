//
//  UIButton+Extension.swift
//  LJ微博
//
//  Created by slj on 15/10/19.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String, color: UIColor = UIColor.darkGrayColor(), imageName: String, fontSize: CGFloat = 12){
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
    }
    
}
