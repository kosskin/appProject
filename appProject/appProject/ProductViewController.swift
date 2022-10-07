//
//  ProductViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 07.10.2022.
//

import UIKit
/// asd
class ProductViewController: UIViewController {

    // MARK: Public Properties
    
    lazy var chooseProductLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 150, width: 100, height: 40))
        label.numberOfLines = 0
        return label
    }()
    
    lazy var chooseProductImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 50, y: 250, width: 200, height: 200))
        return imageView
    }()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: Configuration UI
    
    func configUI() {
        view.addSubview(chooseProductLabel)
        view.addSubview(chooseProductImageView)
    }

}
