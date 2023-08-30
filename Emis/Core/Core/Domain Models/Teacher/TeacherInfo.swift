//
//  TeacherInfo.swift
//  Core
//
//  Created by Shio Birbichadze on 30.08.23.
//

public struct TeacherInfo {
    public init(firstName: String, lastName: String, birthDate: String, email: String, address: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
    }
    
    public let firstName: String
    public let lastName: String
    public let birthDate: String
    public let email: String
    public let address: String
    public let phoneNumber: String
    
    init(with model: ApiTeacherInfo) {
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.birthDate = model.birthDate
        self.email = model.email
        self.address = model.address
        self.phoneNumber = model.phoneNumber
    }
}
