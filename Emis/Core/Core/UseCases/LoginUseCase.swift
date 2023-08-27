//
//  LoginUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

import Combine
import Resolver

public protocol LoginUseCase {
    func loginUser(email: String,
                   password: String) -> AnyPublisher<LoginModel, Error>
}

public class LoginUseCaseImpl: LoginUseCase {
    
    @Injected var loginGateway: LoginGateway
    
    public func loginUser(email: String,
                          password: String) -> AnyPublisher<LoginModel, Error> {
        loginGateway.loginUser(email: email, password: password)
    }
}
