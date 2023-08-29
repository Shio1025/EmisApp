//
//  RoundCorners.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit

public extension UIView {
    func roundCorners(by radius: CGFloat,
                      corners: UIRectCorner = .allCorners,
                      borderColor: UIColor = .clear,
                      borderWidth: CGFloat = .zero) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        if borderWidth != .zero {
            let borderLayer = CAShapeLayer()
            borderLayer.path = path.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            layer.addSublayer(borderLayer)
        }
        
        clipsToBounds = true
    }
}
