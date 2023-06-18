//
//  RoundCorners.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit

public extension UIView {
    func roundCorners(by radius: CGFloat,
                      corners: UIRectCorner = .allCorners) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
