//
//  TabBarController.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.05.23.
//

import UIKit
import BrandBook

class TabBarController: UITabBarController {
    
    var login: TabBarItem = .login
    var main: TabBarItem = .main
    var more: TabBarItem = .more

    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllers()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //round tab Bar
        let path = UIBezierPath(roundedRect: tabBar.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: .L,
                                                    height: .L))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.borderColor = BrandBookManager.Color.Theme.Invert.tr400.cgColor
        tabBar.layer.mask = maskLayer
    }
    
    private func setUpUI() {
        
        tabBar.backgroundColor =  BrandBookManager.Color.Theme.Background.layer.uiColor
        
        let appearance = self.tabBar.standardAppearance.copy()
        appearance.stackedLayoutAppearance.normal.iconColor = BrandBookManager.Color.Theme.Invert.tr100.uiColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: BrandBookManager.Color.Theme.Invert.tr100.uiColor,
                                                                         .font : UIFont.systemFont(ofSize: .M)]
        // unselected text
        appearance.stackedLayoutAppearance.selected.iconColor = BrandBookManager.Color.Theme.Component.solid500.uiColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                                                           .font : UIFont.systemFont(ofSize: .L)]
        // selected text
        
        self.tabBar.standardAppearance = appearance
    }
    
    public func createViewControllers() {
        let firstTab = UINavigationController(rootViewController: login.controller)
        let secondTab = UINavigationController(rootViewController: main.controller)
        let fourthTab = UINavigationController(rootViewController: more.controller)
        viewControllers = [firstTab, secondTab, fourthTab]
        
        
        firstTab.tabBarItem = UITabBarItem(title: login.text, image: login.icon.resizeImage(targetSize: .init(width: .XL4, height: .XL3)), tag: 0)
        secondTab.tabBarItem = UITabBarItem(title: main.text, image: main.icon.resizeImage(targetSize: .init(width: .XL4, height: .XL3)), tag: 1)
        fourthTab.tabBarItem = UITabBarItem(title: more.text, image: more.icon.resizeImage(targetSize: .init(width: .XL4, height: .XL3)), tag: 3)
    }
}
