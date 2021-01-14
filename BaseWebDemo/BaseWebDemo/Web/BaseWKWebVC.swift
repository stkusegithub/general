//
//  BaseWKWebVC.swift
//  iOS_BananaCP
//
//  Created by Stk on 2021/1/11.
//  Copyright © 2021 STK. All rights reserved.
//

import UIKit
import WebKit

class BaseWKWebVC: UIViewController {
    // MARK: - Property
    @objc public var urlStr: String?
    @objc public var localHtml: String?
    
    lazy var config: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.selectionGranularity = .dynamic
        config.allowsInlineMediaPlayback = true
        
        let preference = WKPreferences()
        preference.javaScriptEnabled = true
        preference.javaScriptCanOpenWindowsAutomatically = true
        
        config.preferences = preference
        config.userContentController = WKUserContentController()
        return config
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView.init(frame: CGRect.zero, configuration: self.config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.backgroundColor = .white
        webView.scrollView.bounces = false
        // 添加进度监听
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return webView
    }()
    
    lazy var progress: BaseProgressView = {
        let progress = BaseProgressView.init(frame: CGRect.zero)
        return progress
    }()

    // MARK: - Overide
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSetting()
        loadUI()
        loadRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.webView.frame = CGRect(x: 0, y: kNaviBarHeight, width: kScreenWidth, height: (kScreenHeight - kNaviBarHeight))
        self.progress.frame = CGRect(x: 0, y: kNaviBarHeight, width: kScreenWidth, height: 1.0)// 高度貌似系统固定
    }
    
    // 进度条显示
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(">>>\(self.webView.estimatedProgress)")
            self.progress.show(progress: Float(self.webView.estimatedProgress))
        }
    }
    
    // MARK: - Private Methods
    func loadSetting() {
        if #available(iOS 11.0, *) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        // 设置标题等等
    }
    
    func loadUI() {
        self.view.addSubview(self.webView)
        self.view.addSubview(self.progress)
    }
    
    func loadRequest() {
        // 优先加载本地网页
        if let localUrl = self.localHtml, !localUrl.isEmpty {
            let baseUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
            let filePath = Bundle.main.path(forResource: localUrl, ofType: "html")
            if let htmlPath = filePath, !htmlPath.isEmpty {
                do {
                    let htmlContent = try String(contentsOfFile: htmlPath, encoding: .utf8)
                    self.webView.loadHTMLString(htmlContent, baseURL: baseUrl)
                } catch {
                    
                }
                return
            }
        }
        
        guard let url = self.urlStr, !url.isEmpty else {
            print("地址错误～")
            return
        }
        
        guard var components = URLComponents(string: url) else {
            print("网络加载异常～")
            return
        }
        
        var queryItems = [URLQueryItem]()
        if let items = components.queryItems {
            queryItems.append(contentsOf: items)
        }
        
        // 拼上自定义通用参数
        
        // 请求
        components.queryItems = queryItems;
        
        var request = URLRequest(url: components.url!)
        request.httpShouldHandleCookies = true
        self.webView.load(request)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - WKScriptMessageHandler
extension BaseWKWebVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
            switch message.name {
            case "":
            break
            default:
               break
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension BaseWKWebVC: WKNavigationDelegate {
    // 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
    
    // 页面加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let errors = error as NSError
        if errors.code == NSURLErrorCancelled {
            return
        }
    }
    
    // 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let errors = error as NSError
        if errors.code == NSURLErrorCancelled {
            return
        }
    }
    
    // 发送请求前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    // 收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}

// MARK: - WKUIDelegate
extension BaseWKWebVC: WKUIDelegate {
    
}
