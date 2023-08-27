//
//  LoginModel.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

public struct LoginModel {
    public var successful: Bool?
    public var userType: UserType
    public var userId: Int64?
    
    public init(with model: ApiLoginModel) {
        self.successful = model.successful
        self.userType = UserType(rawValue: model.userType ?? "") ?? .none
        self.userId = model.userId
    }
}


public enum UserType: String {
    case student = "STUDENT"
    case teacher = "TEACHER"
    case none
}
