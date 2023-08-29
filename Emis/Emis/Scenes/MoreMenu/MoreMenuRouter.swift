//
//  MoreMenuRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 20.06.23.
//



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
            break
        }
    }
    
    private func handleLogOut(view: MoreMenuController) {
        guard let tabBarController = view.tabBarController else { return }
        tabBarController.selectedIndex = 0
        guard let navController = tabBarController.selectedViewController,
              let viewController = navController.navigationController
        else { return }
        viewController.setViewControllers([TabBarController()], animated: true)
    }
}
