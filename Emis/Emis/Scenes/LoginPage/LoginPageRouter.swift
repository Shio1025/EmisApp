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
        case .login:
            view.navigationController?.viewControllers = [ProfilePageController(viewModel: ProfilePageViewModel())]
        case .resetPassword:
            view.navigationController?.viewControllers = [PasswordResetController()]
        case .register:
            view.navigationController?.viewControllers = [PasswordResetController()]
        }
    }
}
