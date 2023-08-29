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
    var userType: UserType? { get }
    var userId: Int64? { get }
    var userEmail: String? { get }
    
    func userLoggedInSuccessfully(userId: Int64?,
                                  userEmail: String?,
                                  userType: UserType)
    
    func logOutUser()
}

public class SSOManagerImpl: SSOManager {
    
    public var userId: Int64?
    
    @Published private var isUserLogged: Bool = false
    
    public var isUserLoggedPublisher: Published<Bool>.Publisher { $isUserLogged }
    
    public var userType: UserType?
    
    public var userEmail: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() { }
    
    public func userLoggedInSuccessfully(userId: Int64?,
                                         userEmail: String?,
                                         userType: UserType) {
        self.userType = userType
        self.userId = userId
        self.userEmail = userEmail
        isUserLogged = true
    }
    
    public func logOutUser() {
        userType = nil
        userId = nil
        isUserLogged = false
        userEmail = nil
    }
}
