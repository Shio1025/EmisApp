//
//  UIViewController + Banner.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 26.08.23.
//

import UIKit


public extension UIViewController {
    func displayBanner(with description: String,
                       state: StatusBannerType) {
        let banner = StatusBanner(model: .init(bannerType: state, description: description))
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(banner)
        self
        banner.top(toView: window, constant: -banner.bounds.height)
        banner.left(toView: window, constant: .M)
        banner.right(toView: window, constant: .M)
        
        banner.transform = CGAffineTransform(translationX: 0, y: -banner.bounds.height)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            banner.transform = .identity
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    banner.transform = CGAffineTransform(translationX: 0, y: -banner.bounds.height)
                }) { _ in
                    banner.removeFromSuperview()
                }
            }
        }
    }
}






