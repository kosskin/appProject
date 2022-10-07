//
//  StoreTabBarViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 06.10.2022.
//

import UIKit
/// tabBarControllers: buying, forYou, basket, search, bag
final class StoreTabBarViewController: UITabBarController {

    // MARK: Constants
    
    private enum Constants {
        static let buyingItemTitle = "Buying"
        static let forYouItemTitle = "For you"
        static let basketItemTitle = "Basket"
        static let searchItemTitle = "Поиск"
        static let tabBarColor = UIColor(named: "AppProjectTabBar")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = Constants.tabBarColor
        createTabsAction()
    }
    
    // MARK: Private Properties
    
    func createTabsAction() {
        let buyingViewController = BuyingViewController()
        let forYouViewController = ForYouViewController()
        let searchViewController = SearchViewController()
        let basketViewController = BasketViewController()
        
        let navController = UINavigationController(rootViewController: searchViewController)
                
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.largeTitleTextAttributes =
                    [NSAttributedString.Key.foregroundColor: UIColor.white]
                
        searchViewController.navigationItem.title = Constants.searchItemTitle
        navController.tabBarItem.title = Constants.searchItemTitle
        
        buyingViewController.tabBarItem = UITabBarItem(title: Constants.buyingItemTitle,
                                                       image: UIImage(systemName: "laptopcomputer.and.iphone"), tag: 0)
        forYouViewController.tabBarItem = UITabBarItem(title: Constants.forYouItemTitle,
                                                       image: UIImage(systemName: "person.circle"),
                                                       tag: 1)
        searchViewController.tabBarItem = UITabBarItem(title: Constants.searchItemTitle,
                                                       image: UIImage(systemName: "magnifyingglass"),
                                                       tag: 2)
        basketViewController.tabBarItem = UITabBarItem(title: Constants.basketItemTitle,
                                                       image: UIImage(systemName: "bag"), tag: 3)
        viewControllers = [buyingViewController, forYouViewController, navController, basketViewController]
    }
}
