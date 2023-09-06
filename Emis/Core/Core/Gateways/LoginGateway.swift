//
//  LoginGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol LoginGateway {
    func loginUser(email: String,
                   password: String) -> AnyPublisher<LoginModel, Error>
}

public class LoginGatewayImpl: LoginGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func loginUser(email: String,
                          password: String) -> AnyPublisher<LoginModel, Error> {
        
        let params = ["email": email,
                      "password": password]
        
        let url = apiURLProvider.getURL(path: "/emis/api/authentication/login",
                                        params: params)
        
        let endpoint = EndPoint<ApiLoginModel>(url: url,
                                               method: .post)
        
        let publisher: AnyPublisher<LoginModel, Error> = dataTransport.makeRequest(endpoint)
            .map { apiLoginModel in
                return LoginModel(with: apiLoginModel)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
