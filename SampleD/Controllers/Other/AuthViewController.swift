//
//  AuthViewController.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/8/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = preferences
        let webView = WKWebView(frame: .zero,
                                configuration: config)
        return webView
    }()
    public var completionHandler: ((Bool) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "sign in"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        
    }
    //Exchange the code for access token
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code" })?.value else {
            return
        }
        webView.isHidden = true
        
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code){ [weak self] sucess in
            DispatchQueue.main.async {
            self?.navigationController?.popToRootViewController(animated: true)
            self?.completionHandler?(sucess)
                
                }
            }
      }
}
  


