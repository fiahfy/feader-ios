//
//  WebViewController.swift
//  Feader
//
//  Created by fiahfy on 2017/12/05.
//  Copyright © 2017年 fiahfy. All rights reserved.
//

import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    //MARK: Private
    
    private func load() {
        guard let url = url else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
