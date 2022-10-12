//
//  StoreTabBarViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 06.10.2022.
//

import UIKit
/// класс для отображения экранов "Поиск", "Покупки", "Корзина", "Для вас" с использованием TabBar
final class StoreTabBarViewController: UITabBarController {

    // MARK: Constants
    
    private enum Constants {
        static let buyingItemTitle = "Купить"
        static let forYouItemTitle = "Для вас"
        static let basketItemTitle = "Корзина"
        static let searchItemTitle = "Поиск"
        static let buyingImage = "laptopcomputer.and.iphone"
        static let forYouImage = "person.circle"
        static let searchImage = "magnifyingglass"
        static let bagImage = "bag"
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabsAction()
    }
    
    // MARK: Private Methods

    private func createTabsAction() {
        let buyingViewController = BuyingViewController()
        let forYouViewController = ForYouViewController()
        let searchViewController = SearchViewController()
        let basketViewController = BasketViewController()
        
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        let buyingNavController = UINavigationController(rootViewController: buyingViewController)
        let basketNavController = UINavigationController(rootViewController: basketViewController)
        let forYouNavController = UINavigationController(rootViewController: forYouViewController)
        
        searchViewController.navigationItem.title = Constants.searchItemTitle
        buyingViewController.navigationItem.title = Constants.buyingItemTitle
        forYouViewController.navigationItem.title = Constants.forYouItemTitle
        basketNavController.navigationItem.title = Constants.basketItemTitle
        
        buyingNavController.tabBarItem = UITabBarItem(title: Constants.buyingItemTitle,
                                                       image: UIImage(systemName: Constants.buyingImage), tag: 0)
                
        forYouNavController.tabBarItem = UITabBarItem(title: Constants.forYouItemTitle,
                                                       image: UIImage(systemName: Constants.forYouImage),
                                                       tag: 1)
        
        searchNavController.tabBarItem = UITabBarItem(title: Constants.searchItemTitle,
                                                       image: UIImage(systemName: Constants.searchImage),
                                                       tag: 2)
        
        basketNavController.tabBarItem = UITabBarItem(title: Constants.basketItemTitle,
                                                       image: UIImage(systemName: Constants.bagImage), tag: 3)
        
        viewControllers = [buyingNavController, forYouNavController, searchNavController, basketNavController]
    }
}
