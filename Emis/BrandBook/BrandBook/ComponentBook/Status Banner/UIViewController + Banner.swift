//
//  UIViewController + Banner.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 26.08.23.
//

import UIKit

//Will be fixed
public extension UIViewController {
    func displayBanner(with description: String, state: StatusBannerType) {
        let banner = StatusBanner(model: .init(bannerType: state, description: description))
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(banner)
        
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            banner.topAnchor.constraint(equalTo: window.topAnchor),
            banner.heightAnchor.constraint(equalToConstant: banner.bounds.height)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            banner.transform = CGAffineTransform(translationX: 0, y: banner.bounds.height)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hideBanner(banner: banner)
            }
        }
    }
    
    private func hideBanner(banner: StatusBanner) {
        UIView.animate(withDuration: 0.3, animations: {
            banner.transform = CGAffineTransform.identity
        }) { _ in
            banner.removeFromSuperview()
        }
    }
}



