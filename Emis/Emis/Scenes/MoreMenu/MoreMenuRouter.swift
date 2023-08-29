//
//  MoreMenuRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 20.06.23.
//

import UIKit

final class MoreMenuRouter {
    
    func route(to route: MoreMenuRoute,
               from view: MoreMenuController) {
        switch route {
        case .changePassword:
            break
        case .easyAuthorization:
            break
        case .GPACalculator:
            break
        case .changeTheme:
            break
        case .logOut:
            handleLogOut(view: view)
        }
    }
    
    private func handleLogOut(view: MoreMenuController) {
        guard let tabBarController = view.tabBarController else { return }
        tabBarController.selectedIndex = 0
        let firstTab = UINavigationController(rootViewController: LoginPageController())
        let secondTab = UINavigationController(rootViewController: MainPageController())
        let thirdTab = UINavigationController(rootViewController: TimeTablePage())
        let fourthTab = UINavigationController(rootViewController: MoreMenuController(viewModel: MoreMenuViewModel()))
        tabBarController.viewControllers = [firstTab, secondTab, thirdTab, fourthTab]
        
//        view.tabBarController?.setViewControllers([TabBarController()], animated: true)
    }
}
