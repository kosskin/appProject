//
//  BuyingPageViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 13.10.2022.
//

import UIKit
/// конфигурация pageControllers
final class BuyingPageViewController: UIPageViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let shopImage = UIImage(named: "shop1")
        static let girlImage = UIImage(named: "shop2")
        static let buyingImage = UIImage(named: "shop3")
        static let shopMainText = "Best shopping"
        static let shopSecondaryText = "Buy best thing online"
        static let girlMainText = "Good price"
        static let girlSecondaryText = "We do not have offline place, so we have good price"
        static let buyingMainText = "Win present"
        static let buyingSecondaryText = "If you buy special category thing, you can win good present for you!"
    }
    
    // MARK: UI Elements
    
    lazy var buyingViewControllers = makeViewControllers()
    
    lazy var nextButton = makeNextButton()
    
    lazy var skipButton = makeSkipButton()
    
    lazy var getStartedButton = makeGetStartedButton()
        
    // MARK: Private Properties
    
    private var pages: [BuyingHelper] = []
    
    private var currentIndex = 0
    
    // MARK: Initializers
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        view.backgroundColor = .white
        dataSource = self
        delegate = self
        setViewControllers([buyingViewControllers[0]], direction: .forward, animated: true, completion: nil)
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = .systemGray6
        proxy.currentPageIndicatorTintColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        view.bringSubviewToFront(getStartedButton)
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        setUpPages()
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(getStartedButton)
        getStartedButton.isHidden = true
    }
    
    private func setUpPages() {
        guard let shopImage = Constants.shopImage,
              let girlImage = Constants.girlImage,
              let buyingImage = Constants.buyingImage else { return }
        let shop = BuyingHelper(image: shopImage, mainLabel: Constants.shopMainText,
                                secondaryLabel: Constants.shopSecondaryText)
        let girl = BuyingHelper(image: girlImage, mainLabel: Constants.girlMainText,
                                secondaryLabel: Constants.girlSecondaryText)
        let buying = BuyingHelper(image: buyingImage, mainLabel: Constants.buyingMainText,
                                  secondaryLabel: Constants.buyingSecondaryText)
        pages.append(shop)
        pages.append(girl)
        pages.append(buying)
    }
    
    @objc func showNextPageAction() {
        guard let currentPage = viewControllers?.first else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage)
        else { return }
        setViewControllers([nextPage], direction: .forward, animated: true)
        switch currentIndex {
        case 0, 1:
            getStartedButton.isHidden = true
            nextButton.isHidden = false
            skipButton.isHidden = false
            togglePageControl(hide: false)
        case 2:
            getStartedButton.isHidden = false
            nextButton.isHidden = true
            skipButton.isHidden = true
            togglePageControl(hide: true)
        default:
            break
        }
    }
    
    @objc func hidePageViewControllerAction() {
        dismiss(animated: true)
    }
}

// MARK: Factory

extension BuyingPageViewController {
   
    private func makeViewControllers() -> [HappyShopViewController] {
        var buyingViewContollers: [HappyShopViewController] = []
        for page in pages {
            buyingViewContollers.append(HappyShopViewController(imageAndTexts: page))
        }
        return buyingViewContollers
    }
    
    private func makeNextButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 290, y: 780, width: 80, height: 20))
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showNextPageAction), for: .touchUpInside)
        return button
    }
    
    private func makeSkipButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 50, y: 780, width: 80, height: 20))
        button.setTitle("SKIP", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.addTarget(self, action: #selector(hidePageViewControllerAction), for: .touchUpInside)
        return button
    }
    
    private func makeGetStartedButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 780, width: 150, height: 20))
        button.center.x = view.center.x
        button.backgroundColor = .white
        button.setTitle("GET STARTED!", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(hidePageViewControllerAction), for: .touchUpInside)
        return button
    }
    
    private func togglePageControl(hide: Bool) {
        for subView in self.view.subviews where subView is UIPageControl {
                subView.isHidden = hide
        }
    }
}

// MARK: UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension BuyingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HappyShopViewController,
              let index = buyingViewControllers.firstIndex(of: viewController)
        else { return nil }
        guard index > 0  else { return nil }
        currentIndex = index - 1
        return buyingViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HappyShopViewController,
              let index = buyingViewControllers.firstIndex(of: viewController)
        else { return nil }
        guard index < pages.count - 1 else { return nil }
        currentIndex = index + 1
        return buyingViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let viewController = pendingViewControllers[0] as? HappyShopViewController,
              let index = buyingViewControllers.firstIndex(of: viewController)
        else { return }
        
        viewController.secondaryLabel.alpha = 0
        viewController.mainLabel.alpha = 0
        UIView.animate(withDuration: 2) {
            viewController.mainLabel.alpha = 1
            viewController.secondaryLabel.alpha = 1
        }
        
        switch index {
        case 0, 1:
            getStartedButton.isHidden = true
            nextButton.isHidden = false
            skipButton.isHidden = false
            togglePageControl(hide: false)
        case 2:
            getStartedButton.isHidden = false
            nextButton.isHidden = true
            skipButton.isHidden = true
            togglePageControl(hide: true)
        default:
            break
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
