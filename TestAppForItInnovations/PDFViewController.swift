//
//  PDFViewController.swift
//  TestAppForItInnovations
//
//  Created by Dima Opalko on 09.01.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import UIKit
import WebKit

class PDFViewController: UIViewController, WKNavigationDelegate {

    var linkToDownload = ""
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        downloadPDFFile(link: linkToDownload)
    }
    
    private func downloadPDFFile(link: String) {
        let url: URL! = URL(string: link)
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - WebView Delegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
