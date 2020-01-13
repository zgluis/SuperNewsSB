//
//  RecentPostViewController.swift
//  SuperNewsSB
//
//  Created by Luis Zapata on 12-01-20.
//  Copyright © 2020 Luis Zapata. All rights reserved.
//

import UIKit
import WebKit

class PostViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        if url != nil {
            webView.load(URLRequest(url: URL(string: url!)!))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
}

