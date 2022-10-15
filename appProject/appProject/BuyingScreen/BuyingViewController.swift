//
//  ViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 06.10.2022.
//

import UIKit

/// Экран Покупки
final class BuyingViewController: UIViewController {
            
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        showOnboarding()
    }
    
    // MARK: Private Methods
    
    private func showOnboarding() {
        let userDefaults = UserDefaults.standard
        let isStarted = userDefaults.bool(forKey: "key")
        if !isStarted {
            let pageViewContoller = BuyingPageViewController(transitionStyle: .scroll,
                                                             navigationOrientation: .horizontal)
            userDefaults.setValue(true, forKey: "key")
            present(pageViewContoller, animated: true, completion: nil)
        }
    }
}
