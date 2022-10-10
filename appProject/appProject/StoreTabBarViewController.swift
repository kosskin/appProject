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
        static let buyingItemTitle = "Buying"
        static let forYouItemTitle = "For you"
        static let basketItemTitle = "Basket"
        static let searchItemTitle = "Поиск"
        static let tabBarColor = UIColor(named: "AppProjectTabBar")
        static let buyingImage = "laptopcomputer.and.iphone"
        static let forYouImage = "person.circle"
        static let searchImage = "magnifyingglass"
        static let bagImage = "bag"
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .secondarySystemBackground
        createTabsAction()
    }
    
    // MARK: Private Methods

    private func createTabsAction() {
        let buyingViewController = BuyingViewController()
        let forYouViewController = ForYouViewController()
        let searchViewController = SearchViewController()
        let basketViewController = BasketViewController()
        
        let navController = UINavigationController(rootViewController: searchViewController)
                
//        navController.navigationBar.prefersLargeTitles = true
//        navController.navigationBar.largeTitleTextAttributes =
//                    [NSAttributedString.Key.foregroundColor: UIColor.white]
                
        searchViewController.navigationItem.title = Constants.searchItemTitle
        navController.tabBarItem.title = Constants.searchItemTitle
        
        buyingViewController.tabBarItem = UITabBarItem(title: Constants.buyingItemTitle,
                                                       image: UIImage(systemName: Constants.buyingImage), tag: 0)
                
        forYouViewController.tabBarItem = UITabBarItem(title: Constants.forYouItemTitle,
                                                       image: UIImage(systemName: Constants.forYouImage),
                                                       tag: 1)
        navController.tabBarItem = UITabBarItem(title: Constants.searchItemTitle,
                                                       image: UIImage(systemName: Constants.searchImage),
                                                       tag: 2)
        basketViewController.tabBarItem = UITabBarItem(title: Constants.basketItemTitle,
                                                       image: UIImage(systemName: Constants.bagImage), tag: 3)
        viewControllers = [buyingViewController, forYouViewController, navController, basketViewController]
    }
}
