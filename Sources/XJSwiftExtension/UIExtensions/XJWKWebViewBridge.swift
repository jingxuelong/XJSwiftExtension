//
//  XJTools_Swift
//  Created by JingXueLong.
//  Copyright © 2018 JingXueLong. All rights reserved.
//
//

import UIKit
import WebKit

public typealias BackHandel = (Any,String) ->Void

/// WKWebView 工具 注册回调一个方法搞定
public class XJWKWebViewBridge: NSObject,WKScriptMessageHandler {
    
    var handleArray: [String : BackHandel] = [:]
    
    weak var webView: WKWebView?
    
    public init(webView: WKWebView) {
        self.webView = webView
    }
    
    public func registJSfunc(name: String, backHandel: @escaping BackHandel){
        self.webView?.configuration.userContentController.add(self, name: name)
        handleArray[name] = backHandel
    }
    
    public func removeJSfunc(name: String){
        self.webView?.configuration.userContentController.removeScriptMessageHandler(forName: name)
        handleArray[name] = nil
    }
    
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let handel = handleArray[message.name] else { return }
        handel(message.body, message.name)
    }
    
}
