//
//  OAuthViewController.swift
//  我的微博
//
//  Created by teacher on 15/7/29.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: 搭建界面
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        webView.delegate = self
        
        title = "新浪微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
    }
    
    /// 关闭界面
    func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 加载授权页面
        webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthUrl()))
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    /**
    1. 如果请求的 URL 包含 回调地址，需要判断参数，否则继续加载
    2. 如果请求参数中，包含 code，可以从请求的 url 中获得请求码
    */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL!.absoluteString
        // 判断是否包含回调地址
        if !urlString.hasPrefix(NetworkTools.sharedTools.redirectUri) {
            return true
        }
        
        if let query = request.URL?.query where query.hasPrefix("code=") {
            // 从 query 中截取授权码
            let code = query.substringFromIndex("code=".endIndex)
            // TODO: 换取 TOKEN
            loadAccessToken(code)
        } else {
            close()
        }
        
        return false
    }
    
    private func loadAccessToken(code: String) {
        NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
            if error != nil || result == nil {
                self.netError()
                return
            }
            
            // 字典转模型
            // 1. 用 token 获取的信息创建用户账户模型
            // 2. 异步加载用户信息
            // 3. 保存用户信息(模型中完成)
            UserAccount(dict: result!).loadUserInfo({ (error) -> () in
                if error != nil {
                    self.netError()
                    return
                }
                print("OK")
                
                NSNotificationCenter.defaultCenter().postNotificationName(SLJSwitchVCID, object: false)
                
                 self.close()
                
            })
        }
    }
    deinit {
        print("88")
    }

    
    /// 网络出错处理
    private func netError() {
        SVProgressHUD.showInfoWithStatus("您的网络不给力")
        
        // 延时一段时间再关闭
        let when = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
        dispatch_after(when, dispatch_get_main_queue()) {
            self.close()
        }
    }
}
