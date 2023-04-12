//
//  ViewController.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.04.23.
//

import UIKit
import BrandBook
import Lottie

class ViewController: UIViewController {
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundBehavior = .pauseAndRestore
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.height(equalTo: 200)
        animation.width(equalTo: 200)
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = BrandBookManager.Color.Theme.Component.solid500.uiColor
        animationView.animation = .named(BrandBookManager.Lottie.student_2,bundle: Bundle(identifier: "Shio.BrandBook")!)
        self.view.addSubview(animationView)
        animationView.centerVertically(to: self.view)
        animationView.centerHorizontally(to: self.view)
    }
}

