//
//  UILabel+Extension.swift
//  LJ微博
//
//  Created by slj on 15/10/19.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit

//扩展中创建遍历函数,让外部调用方便,牛逼的方法自己造
extension UILabel {
    convenience init(color: UIColor, fontSize: CGFloat) {
        self.init()
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
    }
}