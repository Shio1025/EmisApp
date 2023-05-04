//
//  EntryPage.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.04.23.
//

import UIKit
import BrandBook
import Lottie

class EntryPage: UIViewController {
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundBehavior = .pauseAndRestore
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addSubviews()
        setUpConstraints()
        handleAnimation()
    }
    
    private func setUpUI() {
       view.backgroundColor = BrandBookManager.Color.Theme.Component.solid500.uiColor
    }
    
    private func addSubviews() {
       view.addSubview(animationView)
    }
    
    private func setUpConstraints() {
        animationView.height(equalTo: 200)
        animationView.width(equalTo: 200)
        animationView.centerVertically(to: self.view)
        animationView.centerHorizontally(to: self.view)
    }
    
    private func handleAnimation() {
        animationView.animation = .named(BrandBookManager.Lottie.student_2,
                                         bundle: Bundle(identifier: "Shio.BrandBook")!)
        animationView.play() {[weak self]_ in
            self?.navigationController?.setViewControllers([TabBarController()], animated: false)
        }
    }
}

