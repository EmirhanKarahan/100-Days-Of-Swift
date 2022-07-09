//
//  DetailViewController.swift
//  Capital Cities
//
//  Created by Emirhan KARAHAN
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    //MARK: - Challenge 3
    
    var selectedCapital:Capital!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://en.wikipedia.org/wiki/" + selectedCapital.title!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
