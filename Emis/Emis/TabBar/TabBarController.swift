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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //round tab Bar
        let path = UIBezierPath(roundedRect: tabBar.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: .L,
                                                    height: .L))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        tabBar.layer.mask = maskLayer
    }
    
    private func setUpUI() {
        
        tabBar.backgroundColor =  BrandBookManager.Color.Theme.Component.solid500.uiColor
        
        let appearance = self.tabBar.standardAppearance.copy()
        appearance.stackedLayoutAppearance.normal.iconColor = BrandBookManager.Color.General.tin.uiColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: BrandBookManager.Color.General.tin.uiColor] // unselected text color
        appearance.stackedLayoutAppearance.selected.iconColor = BrandBookManager.Color.General.black.uiColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: BrandBookManager.Color.General.black.uiColor] // selected text color
        
        self.tabBar.standardAppearance = appearance
    
    }
    
    private func createViewControllers() {
        //Fix later -> now it shows only login page
        let firstTab = login.controller
        let secondTab = main.controller
        let thirdTab = timetable.controller
        let fourthTab = more.controller
        viewControllers = [firstTab, secondTab, thirdTab, fourthTab]
        
        
        firstTab.tabBarItem = UITabBarItem(title: login.text, image: login.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 0)
        secondTab.tabBarItem = UITabBarItem(title: main.text, image: main.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 0)
        thirdTab.tabBarItem = UITabBarItem(title: timetable.text, image: timetable.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 0)
        fourthTab.tabBarItem = UITabBarItem(title: more.text, image: more.icon.resizeImage(targetSize: .init(width: 24, height: 24)), tag: 0)
    }
}
