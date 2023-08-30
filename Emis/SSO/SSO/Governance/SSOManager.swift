//
//  SSOManager.swift
//  SSO
//
//  Created by Shio Birbichadze on 19.06.23.
//

import Combine
import NetworkLayer
import Core

public protocol SSOManager {
    var isUserLoggedPublisher: Published<Bool>.Publisher { get }
    var userInfo: LoginModel? { get }
    var userEmail: String? { get }
    
    func userLoggedInSuccessfully(userEmail: String?,
                                  with userLoginModel: LoginModel)
    
    func logOutUser()
}

public class SSOManagerImpl: SSOManager {
    
    public var userInfo: LoginModel?
    
    @Published private var isUserLogged: Bool = false
    
    public var isUserLoggedPublisher: Published<Bool>.Publisher { $isUserLogged }
    
    public var userEmail: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() { }
    
    public func userLoggedInSuccessfully(userEmail: String?,
                                         with userLoginModel: LoginModel) {
        self.userInfo = userLoginModel
        self.userEmail = userEmail
        isUserLogged = true
    }
    
    public func logOutUser() {
        userInfo = nil
        userEmail = nil
        isUserLogged = false
    }
}
