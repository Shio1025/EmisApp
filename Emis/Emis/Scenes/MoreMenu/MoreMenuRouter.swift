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
        case .GPACalculator:
            view.navigationController?.pushViewController(GpaCalculatorController(), animated: true)
        case .logOut:
            handleLogOut(view: view)
        }
    }
    
    private func handleLogOut(view: MoreMenuController) {
        guard let tabBarController = view.tabBarController  as? TabBarController else { return }
        tabBarController.createViewControllers()
        tabBarController.selectedIndex = 0
    }
}
