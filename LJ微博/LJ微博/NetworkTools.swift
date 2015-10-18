//
//  NetworkTools.swift
//  我的微博
//
//  Created by teacher on 15/7/29.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import AFNetworking

/// 错误的类别标记
private let HMErrorDomainName = "com.itheima.error.network"

/// 网络访问错误信息 - 枚举，是定义一组类似的值
/// Swift 中枚举可以定义函数和属性，跟`类`有点像
private enum HMNetworkError: Int {
    case emptyDataError = -1
    case emptyTokenError = -2
    
    /// 错误描述
    private var errorDescrption: String {
        switch self {
        case .emptyDataError: return "空数据"
        case .emptyTokenError: return "Token 为空"
        }
    }
    
    //根据枚举类型,返回相对应的错误信息
    private func error() -> NSError {
        return NSError(domain: HMErrorDomainName, code: rawValue, userInfo:[HMErrorDomainName:errorDescrption])
    }
}
 /// 网络访问方法
private enum HMNetworkMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    
    // 应用程序信息
    private let clientId = "4169469586"
    private let appSecret = "5a3906d9760307291d1ef61b4f5fd5a8"
    
    /// 回调地址
    let redirectUri = "http://www.baidu.com"
    // MARK: - 类型定义
    /// 网络回调类型别名
    typealias HMNetFinishedCallBack = (result: [String: AnyObject]?, error: NSError?)->()
    
    
    // 单例
    static let sharedTools: NetworkTools = {
        let baseURL = NSURL(string: "https://api.weibo.com/")!
        let tools = NetworkTools(baseURL: baseURL)
        
        // 设置数据解析数据类型
        tools.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as Set<NSObject>
        
        return tools
        }()
    
    // MARK: - 加载用户数据
    /// 加载用户信息 － 职责，做网络访问，获取到 dict
    ///
    /// :param: uid      用户代号字符串
    /// :param: finished 完成回调
    func loadUserInfo(uid: String, finished: HMNetFinishedCallBack) {
        
        // 判断 token 是否存在
        if UserAccount.loadAccount()?.access_token == nil {
            // 错误回调，token 为空
            let error = HMNetworkError.emptyTokenError.error()
            
            print(error)
            finished(result: nil, error: error)
            
            return
        }
        
        let urlString = "2/users/show.json"
        let params: [String: AnyObject] = ["access_token": UserAccount.loadAccount()!.access_token!, "uid": uid]
        
        // 发送网络请求
        // 提示：如果参数不正确，首先用 option + click 确认参数类型
        request(HMNetworkMethod.GET, urlString: urlString, params: params, finished: finished)
    }
    
    // MARK: - OAuth授权
    /// 返回 OAuth 授权地址
    func oauthUrl() -> NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)"
        
        return NSURL(string: urlString)!
    }
    
    /// 加载 Token
    func loadAccessToken(code: String, finished: HMNetFinishedCallBack) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": clientId,
            "client_secret": appSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirectUri]
        
        // 测试代码-设置返回的数据格式
        // responseSerializer = AFHTTPResponseSerializer()
        
        request(HMNetworkMethod.POST, urlString: urlString, params: params, finished: finished)

    }
    
    // MARK: - 封装 AFN 网络方法，便于替换网络访问方法，第三方框架的网络代码全部集中在此
    /// AFN 网络请求 GET / POST
    ///
    /// :param: method    HTTP 方法 GET / POST
    /// :param: urlString URL 字符串
    /// :param: params    字典参数
    /// :param: finished  完成回调
    private func request(method: HMNetworkMethod, urlString: String, params: [String: AnyObject], finished: HMNetFinishedCallBack) {
        
        // 1. 定义成功的闭包
        let successCallBack: (NSURLSessionDataTask!, AnyObject!) -> Void = { (_, JSON) -> Void in
            
            if let result = JSON as? [String: AnyObject] {
                // 有结果的回调
                finished(result: result, error: nil)
            } else {
                // 没有错误，同时没有结果
                print("没有数据 \(method) Request \(urlString)")
                
                finished(result: nil, error: HMNetworkError.emptyDataError.error())
            }
        }
        
        // 2. 定义失败的闭包
        let failedCallBack: (NSURLSessionDataTask!, NSError!) -> Void = { (_, error) -> Void in
            print(error)
            
            finished(result: nil, error: error)
        }
        
        // 3. 根据 method 来选择执行的方法
        switch method {
        case .GET:
            GET(urlString, parameters: params, success: successCallBack, failure: failedCallBack)
        case .POST:
            POST(urlString, parameters: params, success: successCallBack, failure: failedCallBack)
        }
    }
}
