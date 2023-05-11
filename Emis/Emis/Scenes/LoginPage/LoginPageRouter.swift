//
//  LoginPageRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import BrandBook


final class LoginPageRouter {
    
    func route(to route: LoginPageRoute,
               from view: LoginPageController) {
        switch route {
        case .login:
            print("login")
        }
    }
}
