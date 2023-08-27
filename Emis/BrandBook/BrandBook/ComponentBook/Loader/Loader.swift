//
//  Loader.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 27.08.23.
//

import UIKit
import Lottie

class Loader {
    static let shared = Loader()
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundBehavior = .pauseAndRestore
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animation = .named(BrandBookManager.Lottie.loader,
                                     bundle: Bundle(identifier: "Shio.BrandBook")!)
        animation.width(equalTo: 150)
        animation.height(equalTo: 150)
        return animation
    }()
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light) // Adjust the style as needed
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private init() {}
    
    func show() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        keyWindow.addSubview(blurView)
        
        blurView.topNotSafe(toView: keyWindow)
        blurView.bottomNotSafe(toView: keyWindow)
        blurView.left(toView: keyWindow)
        blurView.right(toView: keyWindow)
        
        // Add the activity indicator on top of the blur view
        blurView.contentView.addSubview(animationView)
        
        animationView.centerVertically(to: blurView)
        animationView.centerHorizontally(to: blurView)
        animationView.play()
    }
    
    func hide() {
        animationView.stop()
        animationView.removeFromSuperview()
        
        blurView.removeFromSuperview()
    }
}

