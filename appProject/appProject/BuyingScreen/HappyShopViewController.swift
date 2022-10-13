//
//  CalendarViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 13.10.2022.
//

import UIKit
/// всплывающие экраны "счастливых покупок"
final class HappyShopViewController: UIViewController {
    
    // MARK: UI Elements
    
    private lazy var mainImageView = makeImageView()
    
    lazy var mainLabel = makeMainLabel()
    
    lazy var secondaryLabel = makeSecondaryLabel()
    
    private lazy var subView: [UIView] = [mainImageView, mainLabel, secondaryLabel]
    
    // MARK: Initializers
    
    init(imageAndTexts: BuyingHelper) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        mainImageView.image = imageAndTexts.image
        mainLabel.text = imageAndTexts.mainLabel
        secondaryLabel.text = imageAndTexts.secondaryLabel
        
        for view in subView {
            self.view.addSubview(view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Factory

extension HappyShopViewController {
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.frame = view.bounds
        return imageView
    }
    
    func makeMainLabel() -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 550, width: 400, height: 100)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.center.x = view.center.x
        label.textAlignment = .center
        label.contentMode = .center
        return label
    }
    
    func makeSecondaryLabel() -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 600, width: 400, height: 200)
        label.numberOfLines = 0
        label.center.x = view.center.x
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.contentMode = .center
        return label
    }
}
