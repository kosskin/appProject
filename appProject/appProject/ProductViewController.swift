//
//  ProductViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 07.10.2022.
//

import UIKit
/// экран выбранного продукта
final class ProductViewController: UIViewController {
    
    private enum Constants {
        static let basketButtonTitle = "Добавить в корзину"
        static let heartBarName = "heart"
        static let boxBarName = "square.and.arrow.up"
        static let withCheckMarkText = "Совместимо с Macbook Pro - Евгений"
        static let checkMark = "checkmark.circle.fill"
        static let deliveryText = """
    Заказ сегодня в течении дня, доставка:
    Чт 25 Фев - Бесплатно
    Варианты доставки для местоположения: 115533
"""
        static let boxName = "cube.box"
    }
    
    // MARK: Visual Components
    
    lazy var chooseProductLabel = makeLabel(text: chooseProductLabelText, size: 16, weight: .bold,
                                            xCoordinate: 25, yCoordinate: 120, fontColor: .white)
    
    lazy var priceProductLabel = makeLabel(text: chooseProductPrice, size: 15, weight: .regular,
                                           xCoordinate: 150, yCoordinate: 150, fontColor: .systemGray)
    
    lazy var scrollOneProduct = makeScrollView()
    
    lazy var productImageView = makeImageView(imageName: chooseProductImageViewText[0],
                                              imageRect: CGRect(x: 0, y: 0,
                                                                width: view.bounds.width, height: 200))
    
    lazy var productImageViewTwo = makeImageView(imageName: chooseProductImageViewText[1],
                                              imageRect: CGRect(x: 410, y: 0,
                                                                width: view.bounds.width, height: 200))
    
    lazy var productImageViewThree = makeImageView(imageName: chooseProductImageViewText[2],
                                              imageRect: CGRect(x: 820, y: 0,
                                                                width: view.bounds.width, height: 200))
    
    lazy var smallChooseProductLabel = makeLabel(text: chooseProductLabelText, size: 12, weight: .regular,
                                                 xCoordinate: 65, yCoordinate: 460, fontColor: .systemGray)
    
    lazy var basketButton = makeBasketButton()
    
    lazy var viewWithCheck = makeViewWithImageView()
    
    lazy var longTextLabel = makeViewLongText()
    
    lazy var boxImageView = makeImageViewBox()
    
    lazy var selectColorGrayButton = makeRoundedButton(xCoordinate: 160,
                                                       backColor: .lightGray, selected: false)
    
    lazy var selectColorBlackButton = makeRoundedButton(xCoordinate: 210,
                                                        backColor: .systemGray5, selected: true)
    
    // MARK: Public Properties
    
    lazy var chooseProductLabelText = String()
    lazy var chooseProductImageViewText: [String] = [String]()
    lazy var chooseProductPrice = String()
    lazy var countImages = Int()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: Private Methods

    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(chooseProductLabel)
        view.addSubview(priceProductLabel)
        view.addSubview(scrollOneProduct)
        scrollOneProduct.addSubview(productImageView)
        if countImages > 1 {
            scrollOneProduct.addSubview(productImageViewTwo)
        }
        if countImages > 2 {
            scrollOneProduct.addSubview(productImageViewThree)
        }
        view.addSubview(smallChooseProductLabel)
        view.addSubview(basketButton)
        view.addSubview(viewWithCheck)
        view.addSubview(longTextLabel)
        view.addSubview(boxImageView)
        view.addSubview(selectColorGrayButton)
        view.addSubview(selectColorBlackButton)
        configTabbar()
    }
    
    @objc func selectButtonAction(sender: UIButton) {
        if selectColorBlackButton == sender {
            selectColorGrayButton.isSelected.toggle()
            selectColorGrayButton.layer.borderColor = UIColor.clear.cgColor
            selectColorBlackButton.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            selectColorBlackButton.isSelected.toggle()
            selectColorBlackButton.layer.borderColor = UIColor.clear.cgColor
            selectColorGrayButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
}

// MARK: Factory

extension ProductViewController {
    func makeLabel(text: String,
                   size: CGFloat,
                   weight: UIFont.Weight,
                   xCoordinate: Int,
                   yCoordinate: Int,
                   fontColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.text = text
        label.textAlignment = .center
        label.textColor = fontColor
        label.frame = CGRect(x: xCoordinate, y: yCoordinate,
                             width: Int(view.bounds.width), height: 0)
        label.sizeToFit()
        return label
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollViewRect = CGRect(x: 0, y: 220, width: view.bounds.width, height: 200)
        let scrollView = UIScrollView(frame: scrollViewRect)
        scrollView.contentMode = .scaleAspectFit
        scrollView.contentSize = CGSize(width: Int(scrollView.bounds.width) * countImages,
                                        height: 200)
        scrollView.indicatorStyle = .white
        scrollView.isPagingEnabled = true
        return scrollView
    }
    
    func makeImageView(imageName: String, imageRect: CGRect) -> UIImageView {
        let imageView = UIImageView(frame: imageRect)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeBasketButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 10, y: 680, width: 390, height: 40))
        button.backgroundColor = .systemBlue
        button.setTitle("\(Constants.basketButtonTitle)", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14).bold
        return button
    }
    
    func configTabbar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: Constants.heartBarName)),
            UIBarButtonItem(image: UIImage(systemName: Constants.boxBarName))
        ]
    }
    
    func makeViewWithImageView() -> UIView {
        let uiView = UIView(frame: CGRect(x: 70, y: 630, width: 350, height: 20))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName: Constants.checkMark)
        imageView.tintColor = .green
        uiView.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: 30, y: 0, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        let myMutableString = NSMutableAttributedString(string: Constants.withCheckMarkText)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.systemBlue, range: NSRange(location: 13, length: 21))
        label.attributedText = myMutableString
        uiView.addSubview(label)
        
        return uiView
    }
    
    func makeViewLongText() -> UILabel {
        let label = UILabel(frame: CGRect(x: 40, y: 730, width: 350, height: 60))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        let attributedString = NSMutableAttributedString(string: Constants.deliveryText)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                              value: UIColor.label,
                                              range: NSRange(location: 0, length: 42))
                
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                              value: UIColor.systemBlue,
                                              range: NSRange(location: 72, length: 45))
                
                attributedString.addAttribute(NSAttributedString.Key.font,
                                              value: UIFont.boldSystemFont(ofSize: 12),
                                              range: NSRange(location: 0, length: 42))
        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }
    
    func makeImageViewBox() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 740, width: 20, height: 20))
        imageView.image = UIImage(systemName: Constants.boxName)
        imageView.tintColor = .systemGray
        return imageView
    }

    func makeRoundedButton(xCoordinate: Int, backColor: UIColor,
                           selected: Bool) -> UIButton {
        let button = UIButton(frame: CGRect(x: xCoordinate, y: 535, width: 35, height: 35))
        button.layer.cornerRadius = 17.5
        button.backgroundColor = backColor
        button.layer.borderWidth = 2
        button.isSelected = selected
        button.layer.borderColor = selected ? UIColor.systemBlue.cgColor : UIColor.systemGray.cgColor
        button.addTarget(self, action: #selector(selectButtonAction(sender:)), for: .touchUpInside)
        return button
    }
}
