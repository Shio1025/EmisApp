//
//  MainPage.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.05.23.
//

import UIKit
import BrandBook

class MainPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = BrandBookManager.Color.Theme.Background.canvas.uiColor
    }
}
