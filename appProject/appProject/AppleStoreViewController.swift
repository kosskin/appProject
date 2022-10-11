// 
//  appleStoreViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 11.10.2022.
//

import UIKit
import WebKit
/// экран открытия apple.com с нужным товаром
class AppleStoreViewController: UIViewController {

    // MARK: Visual Components
    
    private lazy var browserWebView = makeWebView(link: appleStoreProduct.link)
    
    private lazy var managingToolBar = makeToolBar()
  
    private lazy var backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                  style: .plain, target: self, action: #selector(goBackAction))
    
    private lazy var forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"),
                                                     style: .plain, target: self, action: #selector(goForwardAction))
    
    private lazy var refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self,
                                                     action: #selector(refreshAction))
    
    private lazy var shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                   style: .plain, target: self, action: #selector(shareAction))
    
    private lazy var spacer = UIBarButtonItem(systemItem: .flexibleSpace)
    
    private var sharePageActivityViewController: UIActivityViewController?
    
    private var oberver: NSKeyValueObservation?
    
    private let progressView = UIProgressView()
    
    // MARK: Public Properties
    
    var appleStoreProduct = Product()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        confgUI()
    }
    
    // MARK: Private Methods
    
    private func confgUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(browserWebView)
        browserWebView.uiDelegate = self
        view = browserWebView
        browserWebView.uiDelegate = self
        managingToolBar.items = [backButton, forwardButton, spacer, refreshButton, shareButton]
        browserWebView.addSubview(managingToolBar)
        progressView.frame = CGRect(x: 110, y: 800, width: 190, height: 30)
        browserWebView.addSubview(progressView)
        oberver = browserWebView.observe(\.estimatedProgress, options: [.new]) { [self] _, _ in
            progressView.progress = Float(browserWebView.estimatedProgress)
            if progressView.progress == 1.0 {
                progressView.isHidden = true
            }
        }
    }
    
    // MARK: Private Methods
    
    @objc func goBackAction() {
        if browserWebView.canGoBack {
            browserWebView.goBack()
        }
    }
    
    @objc func goForwardAction() {
        if browserWebView.canGoForward {
            browserWebView.goForward()
        }
    }
    
    @objc func refreshAction() {
        browserWebView.reload()
    }
    
    @objc func shareAction() {
        sharePageActivityViewController = UIActivityViewController(activityItems: [appleStoreProduct.link],
                                                                   applicationActivities: nil)
        guard let share = sharePageActivityViewController else { return }
        present(share, animated: true, completion: nil)
    }
}

// MARK: Factory
extension AppleStoreViewController {
    func makeWebView(link: String) -> WKWebView {
        let webView = WKWebView()
            if let url = URL(string: link) {
                print(url)
                let request = URLRequest(url: url)
                webView.load(request)
            }
        return webView
    }

    func makeToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 780, width: 414, height: 44))
        toolBar.backgroundColor = .systemGray6
        return toolBar
    }

    func makeNavigationButton(xCoordinate: CGFloat, imageName: String,
                              width: CGFloat, height: CGFloat, function: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: xCoordinate, y: 15,
                                            width: width, height: height))
        button.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
        return button
    }
}
