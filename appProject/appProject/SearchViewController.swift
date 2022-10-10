//
//  SearchViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 06.10.2022.
//

import UIKit
/// экран поиска
final class SearchViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let backgroundColor = UIColor(named: "AppProjectBackground")
        static let colorText = UIColor(named: "AppProjectTextColor")
        static let labelColor = UIColor(named: "AppProjectTextColor")
        static let colorTextView = UIColor(named: "AppProjectGrayTextView")
        static let searchIconColor = UIColor(named: "AppProjectTabBar")
        static let bottomColor = UIColor(named: "AppProjectBottom")
        static let labelSearchText = "Поиск"
        static let searchControllerPlaceholder = "Поиск по продуктам и магазинам"
        static let recentViewLabelText = "Недавно просмотренные"
        static let clearButtonTitle = "Очистить"
        static let blackCaseViewName = "Image"
        static let blackCaseViewNameTwo = "case2"
        static let blackCaseViewNameThree = "case3"
        static let watchViewName = "4"
        static let watchViewNameTwo = "clock2"
        static let brownCaseViewName = "2"
        static let brownCaseViewNameTwo = "caseBrown2"
        static let brownCaseViewNameThree = "caseBrown3"
        static let iPhoneViewName = "iPhone"
        static let blackCaseViewLabel = "Чехол Incase Flat для Macbook Pro 16 дюймов"
        static let watchViewLabel = "Спортивный ремешок Black Unity (для котиков)"
        static let brownCaseViewLabel = "Кожаный чехол для Macbook Pro 16 дюймов, золотой"
        static let iPhoneViewLabel = "IPhone 13 Pro"
        static let variableRequestLabelText = "Варианты запросов"
        static let airPodsViewText = "AirPods"
        static let appleCareViewText = "AppleCare"
        static let beatsViewText = "Beats"
        static let compareIphoneViewText = "Сравните модели iPhone"
        static let searchIconName = "magnifyingglass"
        static let blackCasePrice = "3 990.00 руб."
        static let brownCasePrice = "3 990.00 руб."
        static let watchPrice = "13 990.00 руб."
        static let iPhoneCasePrice = "84 990.00 руб."
    }
    
    // MARK: Visual components

    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchControllerPlaceholder
        return searchController
    }()
    
    private lazy var recentViewLabel = makeLabel(text: Constants.recentViewLabelText,
                                                 size: 21, weight: .bold, xCoordinate: 20, yCoordinate: 225)
    
    private lazy var clearButton = makeButton(title: Constants.clearButtonTitle,
                                              xCoordinate: 325, yCoordinate: 225)
    
    private lazy var blackCaseView = makeViewWithProduct(name: Constants.blackCaseViewName,
                                                    xCoordinate: 0, yCoordinate: 0,
                                                    textLabel: Constants.blackCaseViewLabel)
    
    private lazy var watchView = makeViewWithProduct(name: Constants.watchViewName,
                                                    xCoordinate: 150, yCoordinate: 0,
                                                    textLabel: Constants.watchViewLabel)
    
    private lazy var brownCaseView = makeViewWithProduct(name: Constants.brownCaseViewName,
                                                    xCoordinate: 300, yCoordinate: 0,
                                                    textLabel: Constants.brownCaseViewLabel)
    
    private lazy var iPhoneView = makeViewWithProduct(name: Constants.iPhoneViewName,
                                                      xCoordinate: 450, yCoordinate: 0,
                                                      textLabel: Constants.iPhoneViewLabel)

    private lazy var variableRequestLabel = makeLabel(text: Constants.variableRequestLabelText,
                                                      size: 21, weight: .bold, xCoordinate: 28, yCoordinate: 515)
    
    private lazy var airPodsView = makeViewWithSearchAndLabel(text: Constants.airPodsViewText,
                                                              xCoordinate: 5, yCoordinate: 560)
    
    private lazy var appleCareView = makeViewWithSearchAndLabel(text: Constants.appleCareViewText,
                                                                xCoordinate: 5, yCoordinate: 610)
    
    private lazy var beatsView = makeViewWithSearchAndLabel(text: Constants.beatsViewText,
                                                            xCoordinate: 5, yCoordinate: 660)
    
    private lazy var compareIphoneView = makeViewWithSearchAndLabel(text: Constants.compareIphoneViewText,
                                                                xCoordinate: 5, yCoordinate: 710)
    
    private lazy var productScrollView = makeScrollView()
    
    // MARK: Private Properties
    
    private lazy var productList: [(String, String)] = [
        (Constants.blackCaseViewLabel, Constants.blackCaseViewName),
        (Constants.watchViewLabel, Constants.watchViewName),
        (Constants.brownCaseViewLabel, Constants.brownCaseViewName),
        (Constants.iPhoneViewLabel, Constants.iPhoneViewName)
    ]
    
    private lazy var products: [Product] = [
        Product(name: Constants.blackCaseViewLabel, price: Constants.blackCasePrice,
                imagesName: [Constants.blackCaseViewName, Constants.blackCaseViewNameTwo,
                             Constants.blackCaseViewNameThree]),
        Product(name: Constants.watchViewLabel, price: Constants.watchPrice,
                imagesName: [Constants.watchViewName, Constants.watchViewNameTwo]),
        Product(name: Constants.brownCaseViewLabel, price: Constants.brownCasePrice,
                imagesName: [Constants.brownCaseViewName, Constants.brownCaseViewNameTwo,
                             Constants.brownCaseViewNameThree]),
        Product(name: Constants.iPhoneViewLabel, price: Constants.iPhoneCasePrice,
                imagesName: [Constants.iPhoneViewName])
    ]
    
    // MARK: Public Properties
    
    var productInfo: Product?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: Private Methods

    func configUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        view.addSubview(recentViewLabel)
        view.addSubview(clearButton)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        blackCaseView.tag = 0
        productScrollView.addSubview(blackCaseView)
        watchView.tag = 1
        productScrollView.addSubview(watchView)
        brownCaseView.tag = 2
        productScrollView.addSubview(brownCaseView)
        iPhoneView.tag = 3
        productScrollView.addSubview(iPhoneView)
        view.addSubview(variableRequestLabel)
        view.addSubview(airPodsView)
        view.addSubview(appleCareView)
        view.addSubview(beatsView)
        view.addSubview(compareIphoneView)
        view.addSubview(productScrollView)
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        let productViewController = ProductViewController()
        productInfo = products[sender.view?.tag ?? 0]
        productViewController.chooseProductLabelText = productInfo?.name ?? "no product"
        productViewController.chooseProductImageViewText = productInfo?.imagesName ?? ["no product"]
        productViewController.chooseProductPrice = productInfo?.price ?? "no product"
        productViewController.countImages = productViewController.chooseProductImageViewText.count
        navigationController?.pushViewController(productViewController, animated: true)
    }
}

// MARK: Factory

extension SearchViewController {
    func makeLabel(text: String,
                   size: CGFloat,
                   weight: UIFont.Weight,
                   xCoordinate: Int,
                   yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.text = text
        label.textColor = Constants.labelColor
        label.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 0, height: 0)
        label.sizeToFit()
        return label
    }
    
    func makeTextField(placeholder: String,
                       xCoordinate: Int,
                       yCoordinate: Int) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 300, height: 40)
        textField.placeholder = placeholder
        textField.tintColor = Constants.colorText
        textField.leftView = UIImageView(image: UIImage(systemName: Constants.searchIconName))
        textField.leftViewMode = .always
        textField.leftView?.tintColor = .systemGray
        return textField
    }
    
    func makeViewWithSearchAndLabel(text: String,
                                    xCoordinate: Int,
                                    yCoordinate: Int) -> UIView {
        let uiView = UIView(frame: CGRect(x: xCoordinate, y: yCoordinate, width: 400, height: 40))
        let label = UILabel(frame: CGRect(x: 50, y: 10, width: 300, height: 20))
        let imageView = UIImageView(image: UIImage(systemName: Constants.searchIconName))
        imageView.frame = CGRect(x: 20, y: 10, width: 20, height: 20)
        imageView.tintColor = .systemGray
        label.text = text
        label.textColor = Constants.colorText
        let bottomView = UIView(frame: CGRect(x: xCoordinate, y: Int(uiView.frame.height - 1),
                                              width: 400, height: 1))
        bottomView.backgroundColor = Constants.bottomColor
        uiView.addSubview(label)
        uiView.addSubview(imageView)
        uiView.addSubview(bottomView)
        return uiView
    }
    
    func makeViewWithProduct(name: String,
                             xCoordinate: Int,
                             yCoordinate: Int, textLabel: String) -> UIView {
        let view = UIView(frame: CGRect(x: xCoordinate, y: yCoordinate, width: 140, height: 180))
        let imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: view.frame.width - 40,
                                                  height: view.frame.width - 40))
        imageView.image = UIImage(named: name)
        let label = UILabel(frame: CGRect(x: 10, y: 120, width: 105, height: 60))
        label.text = textLabel
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.numberOfLines = 3
        label.textColor = Constants.colorText
        imageView.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.colorTextView
        view.clipsToBounds = true
        view.addSubview(imageView)
        view.addSubview(label)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        return view
    }
    
    func makeButton(title: String,
                    xCoordinate: Int,
                    yCoordinate: Int) -> UIButton {
        let button = UIButton(frame: CGRect(x: xCoordinate, y: yCoordinate, width: 100, height: 50))
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollViewRect = CGRect(x: 5, y: 290, width: view.frame.width,
                                    height: 180)
        let scrollView = UIScrollView(frame: scrollViewRect)
        scrollView.contentSize = CGSize(width: view.frame.width + 185,
                                        height: scrollView.frame.height)
        scrollView.contentMode = .scaleAspectFit
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
}
