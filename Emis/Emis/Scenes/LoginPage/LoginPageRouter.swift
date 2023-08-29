//
//  LoginPageRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//


final class LoginPageRouter {
    
    func route(to route: LoginPageRoute,
               from view: LoginPageController) {
        switch route {
        case .profile:
            view.navigationController?.viewControllers = [ProfilePageController()]
        case .resetPassword:
            view.navigationController?.pushViewController(PasswordResetController(), animated: true)
        case .register:
            view.navigationController?.pushViewController(PasswordResetController(), animated: true)
        }
    }
}
