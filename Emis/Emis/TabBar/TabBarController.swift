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
    var profile: TabBarItem = .profile
    var main: TabBarItem = .main
    var timetable: TabBarItem = .timetable
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
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: BrandBookManager.Color.Theme.Invert.tr100.uiColor] // unselected text color
        appearance.stackedLayoutAppearance.selected.iconColor = BrandBookManager.Color.Theme.Component.solid500.uiColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: BrandBookManager.Color.Theme.Component.solid500.uiColor] // selected text color
        
        self.tabBar.standardAppearance = appearance
    }
    
    private func createViewControllers() {
        //Fix later -> now it shows only login page
        let firstTab = UINavigationController(rootViewController: login.controller)
        let secondTab = UINavigationController(rootViewController: main.controller)
        let thirdTab = UINavigationController(rootViewController: timetable.controller)
        let fourthTab = UINavigationController(rootViewController: more.controller)
        viewControllers = [firstTab, secondTab, thirdTab, fourthTab]
        
        
        firstTab.tabBarItem = UITabBarItem(title: login.text, image: login.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 0)
        secondTab.tabBarItem = UITabBarItem(title: main.text, image: main.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 1)
        thirdTab.tabBarItem = UITabBarItem(title: timetable.text, image: timetable.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 2)
        fourthTab.tabBarItem = UITabBarItem(title: more.text, image: more.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 3)
    }
}
