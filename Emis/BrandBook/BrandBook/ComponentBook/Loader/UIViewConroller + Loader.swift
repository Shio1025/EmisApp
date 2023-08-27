//
//  UIViewConroller + Loader.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 27.08.23.
//

import UIKit

public extension UIViewController {
    func showLoader() {
        Loader.shared.show()
    }
    
    func hideLoader() {
        Loader.shared.hide()
    }
}
