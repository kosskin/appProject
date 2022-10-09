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
        static let watchViewName = "4"
        static let brownCaseViewName = "2"
        static let blackCaseViewLabel = "Чехол Incase Flat для Macbook Pro 16 дюймов"
        static let watchViewLabel = "Спортивный ремешок Black Unity (для котиков)"
        static let brownCaseViewLabel = "Кожаный чехол для Macbook Pro 16 дюймов, золотой"
        static let variableRequestLabelText = "Варианты запросов"
        static let airPodsViewText = "AirPods"
        static let appleCareViewText = "AppleCare"
        static let beatsViewText = "Beats"
        static let compareIphoneViewText = "Сравните модели iPhone"
        static let searchIconName = "magnifyingglass"

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
                                                    xCoordinate: 20, yCoordinate: 290,
                                                    textLabel: Constants.blackCaseViewLabel)
    
    private lazy var watchView = makeViewWithProduct(name: Constants.watchViewName,
                                                    xCoordinate: 170, yCoordinate: 290,
                                                    textLabel: Constants.watchViewLabel)
    
    private lazy var brownCaseView = makeViewWithProduct(name: Constants.brownCaseViewName,
                                                    xCoordinate: 320, yCoordinate: 290,
                                                    textLabel: Constants.brownCaseViewLabel)

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
    
    // MARK: Private Properties
    
    private lazy var productList: [(String, String)] = [
        (Constants.blackCaseViewLabel, Constants.blackCaseViewName),
        (Constants.watchViewLabel, Constants.watchViewName),
        (Constants.brownCaseViewLabel, Constants.brownCaseViewName)
    ]
    private lazy var productLabelName = String()
    private lazy var productImageName = String()
    
    // MARK: Public Properties
    
    var productInfo: (String, String) = ("", "")
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: Private Methods

    func configUI() {
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(recentViewLabel)
        view.addSubview(clearButton)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        blackCaseView.tag = 0
        view.addSubview(blackCaseView)
        watchView.tag = 1
        view.addSubview(watchView)
        brownCaseView.tag = 2
        view.addSubview(brownCaseView)
        view.addSubview(variableRequestLabel)
        view.addSubview(airPodsView)
        view.addSubview(appleCareView)
        view.addSubview(beatsView)
        view.addSubview(compareIphoneView)
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        let productViewController = ProductViewController()
        guard let senderView = self.view else { return }
        productInfo = productList[senderView.tag]
        productViewController.chooseProductLabel.text = productInfo.0
        productViewController.chooseProductImageView.image = UIImage(named: productInfo.1)
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
}

// MARK: UIScrollViewDelegate
