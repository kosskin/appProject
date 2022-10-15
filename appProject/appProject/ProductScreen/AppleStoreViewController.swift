// 
//  appleStoreViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 11.10.2022.
//

import UIKit
import WebKit

/// Экран открытия apple.com с нужным товаром
final class AppleStoreViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let backButtonName = "chevron.left"
        static let forwardButtonName = "chevron.right"
        static let shareButtonName = "square.and.arrow.up"
    }

    // MARK: Visual Components
    
    private lazy var browserWebView = makeWebView(link: appleStoreProduct.link)
    private lazy var managingToolBar = makeToolBar()
    private lazy var backButton = UIBarButtonItem(image: UIImage(systemName: Constants.backButtonName),
                                                  style: .plain, target: self, action: #selector(goBackAction))
    private lazy var forwardButton = UIBarButtonItem(image: UIImage(systemName: Constants.forwardButtonName),
                                                     style: .plain, target: self, action: #selector(goForwardAction))
    private lazy var refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self,
                                                     action: #selector(refreshAction))
    private lazy var shareButton = UIBarButtonItem(image: UIImage(systemName: Constants.shareButtonName),
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
        oberver = browserWebView.observe(\.estimatedProgress, options: [.new]) { [weak self] _, _ in
            guard let self = self else { return }
            self.progressView.progress = Float(self.browserWebView.estimatedProgress)
            if self.progressView.progress == 1.0 {
                self.progressView.isHidden = true
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
