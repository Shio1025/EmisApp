//
//  SSOManager.swift
//  SSO
//
//  Created by Shio Birbichadze on 19.06.23.
//

import Combine

public protocol SSOManager {
    var isUserLoggedPublisher: Published<Bool>.Publisher { get }
    var user: User? { get }
    var userType: UserType? { get }
    
    func logInUser(email: String, password: String) -> AnyPublisher<Bool, Error>
    func logOutUser()
}

public class SSOManagerImpl: SSOManager {
    
    @Published private var isUserLogged: Bool = false
    
    public var isUserLoggedPublisher: Published<Bool>.Publisher { $isUserLogged }
    
    public var user: User?
    
    public var userType: UserType?
    
    
    public init() { }
    
    public func logInUser(email: String, password: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            self.isUserLogged = true
            self.user = user1
            self.userType = user1.userType
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
    
    public func logOutUser() {
        user = nil
        userType = nil
        isUserLogged = false
    }
}

enum CustomError: Error {
    case loginFailed
}
