//
//  LoginPageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import BrandBook
import Combine
import Resolver

enum LoginPageRoute {
    case login
}

final class LoginPageViewModel {
    
    @Published private var router: LoginPageRoute?
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() { }
    
}

extension LoginPageViewModel {
    
    func getRouter() -> AnyPublisher<LoginPageRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}
