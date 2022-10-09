//
//  UIView+Extension.swift
//  appProject
//
//  Created by Валентин Коскин on 07.10.2022.
//

import UIKit
/// Расширение для создания линии
extension UIView {
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width - 10,
                              height: self.frame.size.height)
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
}
