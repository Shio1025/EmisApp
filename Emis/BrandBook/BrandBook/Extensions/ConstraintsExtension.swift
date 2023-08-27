//
//  ConstraintsExtension.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.04.23.
//

import UIKit

public extension UIView {
    
    @discardableResult
    func left(toView view: UIView,
              constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: value)
        result.isActive = true
        return result
    }
    
    func relativeLeft(toView view: UIView,
                      constant value: CGFloat) {
        self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: value).isActive = true
    }
    
    @discardableResult
    func right(toView view: UIView,
               constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -value)
        result.isActive = true
        return result
    }
    
    func relativeRight(toView view: UIView,
                       constant value: CGFloat) {
        self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: value).isActive = true
    }
    
    @discardableResult
    func top(toView view: UIView,
             constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: value)
        result.isActive = true
        return result
    }
    
    func relativeTop(toView view: UIView,
                     constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: value).isActive = true
    }
    
    @discardableResult
    func bottom(toView view: UIView,
                constant value: CGFloat = 0) -> NSLayoutConstraint {
        let result = self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -value)
        result.isActive = true
        return result
    }
    
    func relativeBottom(toView view: UIView,
                        constant value: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -value).isActive = true
    }
    
    func height(equalTo constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func width(equalTo constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func centerVertically(to view: UIView) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func centerHorizontally(to view: UIView) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func bottomNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -value).isActive = true
    }
    
    func topNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: -value).isActive = true
    }
}
