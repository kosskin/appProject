//
//  ForYouViewController.swift
//  appProject
//
//  Created by Валентин Коскин on 06.10.2022.
//
//
import UIKit

/// Экран для вас
final class ForYouViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Constants
    
    private enum Constants {
        static let forYouTitleText = "Для вас"
        static let whatNewLabelText = "Вот что нового"
        static let deliveryStatusText = "Ваш заказ отправлен."
        static let amountAndDateText = "1 доставка, доставка завтра"
        static let processedText = "Обрабатывается"
        static let sentText = "Отправлено"
        static let deliveredText = "Доставлено"
        static let recomendasionText = "Рекомендуется Вам"
        static let recomendNewsText = "Получайте новости o своём заказе в режиме реального времени"
        static let recomendNotificationText = "Включите уведомления, чтобы получать новости о своём заказе"
        static let yourDeviceText = "ваши устройства"
        static let showAllText = "Показать все"
        static let airPodsImageName = "apple-airpod"
        static let arrowButtonName = "chevron.right"
        // Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 40
        // Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        // Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        // Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        // Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        // Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        // Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    // MARK: UI Elements
    
    lazy var forYouScrollView = makeScrollView()
    lazy var bottomView = makeBottomView()
    lazy var deliveryStatusView = makeDeliveryStatusView()
    lazy var whatNewLabel = makeLabel(xCoordinate: 20, yCoordinate: 140,
                                      text: Constants.whatNewLabelText, size: 26)
    lazy var processingLabel = makeProcessLabel(xCoordinate: 16, text: Constants.processedText, color: .black)
    lazy var sentLabel = makeProcessLabel(xCoordinate: 160, text: Constants.sentText, color: .black)
    lazy var deliveredLabel = makeProcessLabel(xCoordinate: 300, text: Constants.deliveredText, color: .systemGray)
    lazy var recomendationLabel = makeLabel(xCoordinate: 22, yCoordinate: 440,
                                            text: Constants.recomendasionText, size: 24)
    lazy var yourDevices = makeLabel(xCoordinate: 22, yCoordinate: 690,
                                     text: Constants.yourDeviceText, size: 26)
    lazy var showAll = makeShowAllLabel()
    lazy var deliveryArrowButton = makeArrowButton(frame: CGRect(x: 350, y: 40, width: 10, height: 18),
                                                   textColor: .systemGray5)
    lazy var recomedationArrowButton = makeArrowButton(frame: CGRect(x: 380, y: 595, width: 10, height: 15),
                                                       textColor: .systemGray)
    lazy var recomendationView = makeRecomendationView()
    lazy var redSquareImageView = makeRedSqureImageView()
    lazy var deliveryProgressView = makeProgressView()
    lazy var imageView = UIImageView(image: UIImage(named: "image_name"))
    lazy var avatarImageView = makeAvatarImageView()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        deliveryStatusView.addSubview(processingLabel)
        deliveryStatusView.addSubview(sentLabel)
        deliveryStatusView.addSubview(deliveredLabel)
        deliveryStatusView.addSubview(deliveryArrowButton)
        deliveryStatusView.addSubview(deliveryProgressView)
        forYouScrollView.addSubview(bottomView)
        forYouScrollView.addSubview(whatNewLabel)
        forYouScrollView.addSubview(recomendationLabel)
        forYouScrollView.addSubview(deliveryStatusView)
        forYouScrollView.addSubview(yourDevices)
        forYouScrollView.addSubview(showAll)
        forYouScrollView.addSubview(recomedationArrowButton)
        forYouScrollView.addSubview(recomendationView)
        forYouScrollView.addSubview(redSquareImageView)
        view.addSubview(forYouScrollView)
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = Constants.ImageSizeForLargeState / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Constants.ImageRightMargin),
            avatarImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Constants.ImageBottomMarginForLargeState),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.ImageSizeForLargeState),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
            ])
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showGallery)))
        avatarImageView.image = checkUserDefaults()
    }
    
    @objc func showGallery(tap: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
}

// MARK: Factory

extension ForYouViewController {
    private func makeBottomView() -> UIView {
        let bottomView = UIView(frame: CGRect(x: view.bounds.origin.x, y: 125,
                                              width: view.bounds.width, height: 1))
        bottomView.backgroundColor = .systemGray
        return bottomView
    }
    
    private func makeDeliveryStatusView() -> UIView {
        let deliveryView = UIView(frame: CGRect(x: 20, y: 220, width: 370, height: 150))
        deliveryView.backgroundColor = .white
        deliveryView.layer.cornerRadius = 10
        let deliveryStatusLabel = UILabel(frame: CGRect(x: 80, y: 20, width: 200, height: 20))
        deliveryStatusLabel.font = UIFont.systemFont(ofSize: 16)
        deliveryStatusLabel.text = Constants.deliveryStatusText
        deliveryStatusLabel.textColor = .black
        deliveryView.addSubview(deliveryStatusLabel)
        let amountAndDateLabel = UILabel(frame: CGRect(x: 80, y: 45, width: 200, height: 20))
        amountAndDateLabel.font = UIFont.systemFont(ofSize: 14)
        amountAndDateLabel.text = Constants.amountAndDateText
        amountAndDateLabel.textColor = .systemGray
        deliveryView.addSubview(amountAndDateLabel)
        let imageView = UIImageView(image: UIImage(named: Constants.airPodsImageName))
        imageView.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        deliveryView.addSubview(imageView)
        let bottomView = UIView(frame: CGRect(x: view.bounds.origin.x, y: 95,
                                              width: 370, height: 1))
        bottomView.backgroundColor = .systemGray
        deliveryView.addSubview(bottomView)
        deliveryView.layer.shadowColor = UIColor.gray.cgColor
        deliveryView.layer.shadowOpacity = 0.6
        deliveryView.layer.shadowOffset = .zero
        deliveryView.layer.shadowRadius = 20
        return deliveryView
    }
    
    private func makeProcessLabel(xCoordinate: CGFloat, text: String, color: UIColor) -> UILabel {
        let label = UILabel(frame: CGRect(x: xCoordinate, y: 125, width: 100, height: 15))
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = text
        label.textColor = color
        return label
    }
    
    private func makeLabel(xCoordinate: CGFloat, yCoordinate: CGFloat,
                           text: String, size: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: xCoordinate, y: yCoordinate, width: 300, height: 40))
        label.text = text
        label.font = UIFont.systemFont(ofSize: size).bold
        return label
    }
    
    private func makeShowAllLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 280, y: 705, width: 100, height: 15))
        label.text = Constants.showAllText
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }
    
    private func makeArrowButton(frame: CGRect, textColor: UIColor) -> UIButton {
        let button = UIButton(frame: frame)
        button.setBackgroundImage(UIImage(systemName: Constants.arrowButtonName), for: .normal)
        button.tintColor = textColor
        return button
    }
    
    private func makeRecomendationView() -> UIView {
        let recomendationView = UIView(frame: CGRect(x: 100, y: 550, width: 200, height: 150))
        let newsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        newsLabel.text = Constants.recomendNewsText
        newsLabel.font = UIFont.systemFont(ofSize: 15).bold
        newsLabel.numberOfLines = 3
        recomendationView.addSubview(newsLabel)
        let notificationLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 250, height: 60))
        notificationLabel.text = Constants.recomendNotificationText
        notificationLabel.font = .systemFont(ofSize: 14)
        notificationLabel.numberOfLines = 2
        notificationLabel.textColor = .systemGray
        recomendationView.addSubview(notificationLabel)
        return recomendationView
    }
    
    private func makeScrollView() -> UIScrollView {
        let scrollViewRect = CGRect(x: 0, y: -130, width: view.frame.width,
                                    height: view.frame.height)
        let scrollView = UIScrollView(frame: scrollViewRect)
        scrollView.contentSize = CGSize(width: view.frame.width ,
                                        height: scrollView.frame.height + 200)
        scrollView.contentMode = .scaleAspectFit
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    private func makeRedSqureImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 25, y: 555, width: 40, height: 40))
        imageView.image = UIImage(systemName: "app.badge")
        imageView.tintColor = .systemPink
        return imageView
    }
    
    private func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame = CGRect(x: 10, y: 110, width: 350, height: 20)
        progressView.setProgress(0.5, animated: false)
        progressView.tintColor = .green
        return progressView
    }
    
    private func makeAvatarImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "2"))
        return imageView
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Constants.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Constants.NavBarHeightLargeState - Constants.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Constants.ImageSizeForSmallState / Constants.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = Constants.ImageSizeForLargeState * (1.0 - factor) // 8.0

        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Constants.ImageBottomMarginForLargeState -
                Constants.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff *
                                                    (Constants.ImageBottomMarginForSmallState + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        avatarImageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    // userDefaults
    private func saveToUserDefaults(image: Data) {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: "Photo") != nil else {
            defaults.setValue(image, forKey: "Photo")
            return
        }
        defaults.removeObject(forKey: "Photo")
        defaults.setValue(image, forKey: "Photo")
    }
    
    private func checkUserDefaults() -> UIImage? {
        let userDefaults = UserDefaults.standard
        guard let dataImage = userDefaults.object(forKey: "Photo") as? Data else {
            let image = UIImage(named: "2")?.resizeImage(to: CGSize(width: 35, height: 35))
            return image
        }
        guard let image = UIImage(data: dataImage) else {
            let image = UIImage(named: "2")?.resizeImage(to: CGSize(width: 35, height: 35))
            return image
            }
        return image
    }
}

// MARK: UIScrollViewDelegate

extension ForYouViewController: UIScrollViewDelegate {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let height = navigationController?.navigationBar.frame.height else { return }
            moveAndResizeImage(for: height)
        }
    }

extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

// MARK: UIImagePickerControllerDelegate

extension ForYouViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
           _ picker: UIImagePickerController, didFinishPickingMediaWithInfo
            info: [UIImagePickerController.InfoKey: Any]) {
           guard let image = info[.editedImage] as? UIImage else { return }
           let img = image.resizeImage(to: CGSize(width: 30, height: 30))
           avatarImageView.image = img
           guard let imageData = image.pngData() else { return }
           saveToUserDefaults(image: imageData)
           self.dismiss(animated: true)
       }
}
