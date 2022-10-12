//
//  SwiftPdfViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 11.10.2022.
//
import UIKit
import WebKit
/// экран для отображения файла swift.pdf
final class SwiftPdfViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let pdfName = "swift"
        static let extensionPdf = "pdf"
    }
    
    // MARK: Viual Components
    
    private lazy var pdfView = makeWebView()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(pdfView)
        view = pdfView
    }
}

// MARK: Factory

extension SwiftPdfViewController {
    func makeWebView() -> WKWebView {
        let webView = WKWebView()
        if let urlPdf = Bundle.main.url(forResource: Constants.pdfName, withExtension: Constants.extensionPdf) {
            let request = URLRequest(url: urlPdf)
            webView.load(request)
            }
        return webView
    }
}
