//
//  StudentInfo.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct StudentInfo {
    public let firstName: String
    public let lastName: String
    public let birthDate: String
    public let email: String
    public let address: String
    public let phoneNumber: String
    public let status: StudentStatus
    public let degreeLevel: DegreeLevel
    public let credits: Int
    public let gpa: Double
    
    init(with model: ApiStudentInfo) {
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.birthDate = model.birthDate
        self.email = model.email
        self.address = model.address
        self.phoneNumber = model.phoneNumber
        self.status = StudentStatus(rawValue: model.status) ?? .active
        self.degreeLevel = DegreeLevel(rawValue: model.degreeLevel) ?? .bachelor
        self.credits = model.credits
        self.gpa = model.gpa
    }
}

public enum StudentStatus: String {
    case active = "ACTIVE"
    case graduate = "GRADUATE"
    case inactive = "NON_ACTIVE"
}

public enum DegreeLevel: String {
    case bachelor = "BACHELOR"
    case master = "MASTERS"
    case doctoral = "DOCTORATE"
}
