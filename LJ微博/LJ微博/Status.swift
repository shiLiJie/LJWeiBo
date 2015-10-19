//
//  Status.swift
//  LJ微博
//
//  Created by slj on 15/10/18.
//  Copyright © 2015年 slj. All rights reserved.
//

import UIKit
/// 微博数据模型
class Status: NSObject {
    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: AnyObject]]?
    /// 用户
    var user: User?
    /// 加载微博数据 - 返回`微博`数据的数组
    class func loadStatus(finished: (dataList: [Status]?, error: NSError?) -> ()) {
        
        NetworkTools.sharedTools.loadStatus { (result, error) -> () in
            
            if error != nil {
                finished(dataList: nil, error: error)
                return
            }
            
            /// 判断能否获得字典数组
            if let array = result?["statuses"] as? [[String: AnyObject]] {
                // 遍历数组，字典转模型
                var list = [Status]()
                
                for dict in array {
                    list.append(Status(dict: dict))
                }
                
                // 获得完整的微博数组，可以回调
                finished(dataList: list, error: nil)
            } else {
                finished(dataList: nil, error: nil)
            }
        }
    }
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        
        // 会调用 setValue forKey 给每一个属性赋值
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        // 判断 key 是否是 user，如果是 user 单独处理
        if key == "user" {
            // 判断 value 是否是一个有效的字典
            if let dict = value as? [String: AnyObject] {
                // 创建用户数据
                user = User(dict: dict)
            }
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["created_at", "id", "text", "source", "pic_urls"]
        
        return "\(dictionaryWithValuesForKeys(keys))"
    }
    

}

