//
//  DetailVC.swift
//  TD assignment
//
//  Created by Sacha Sukhdeo on 2018-10-22.
//  Copyright © 2018 Sacha Sukhdeo. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var link: URL? {
        get {
            return self.link
        }
        set(url) {
            if let url = url {
                if Reachability.isConnectedToNetwork() == true {
                    self.request = URLRequest(url: url,
                                              cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                              timeoutInterval: 10.0)
                }
                else {
                    Reachability.showNoConnectionAlert()
                }
            }
        }
    }
    
    var request: URLRequest?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        spinner.stopAnimating()
        if let request = request {
            webview.navigationDelegate = self
            webview.load(request)
            spinner.isHidden = false
            spinner.startAnimating()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        request = URLRequest(url: URL(string: "about:blank")!)
        webview.load(request!)
        URLCache.shared.removeAllCachedResponses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
    
}

