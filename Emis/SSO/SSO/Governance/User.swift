//
//  User.swift
//  SSO
//
//  Created by Shio Birbichadze on 19.06.23.
//

public class User: ObservableObject {
    public var userType: UserType
    public var name: String
    public var surname: String
    public var phoneNumber: String
    public var birthDate: String
    public var imageURL: String
    
    public var currentTerm: Int
    public var status: StudentStatus
    public var group: String
    public var GPA: Double
    public var totalCredits: Int
    public var speciality: String
    public var gradesURL: String
    
    public var finances: FinanceInfo
    
    public init(userType: UserType,
                name: String,
                surname: String,
                phoneNumber: String,
                birthDate: String,
                imageURL: String,
                currentTerm: Int,
                status: StudentStatus,
                group: String,
                GPA: Double,
                totalCredits: Int,
                speciality: String,
                gradesURL: String,
                finances: FinanceInfo) {
        self.userType = userType
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.imageURL = imageURL
        self.currentTerm = currentTerm
        self.status = status
        self.group = group
        self.GPA = GPA
        self.totalCredits = totalCredits
        self.speciality = speciality
        self.gradesURL = gradesURL
        self.finances = finances
    }
}

public enum UserType {
    case student
    case lecturer
    case none
}

public enum StudentStatus {
    case active
    case inactive
    
    public var desc: String {
        switch self {
        case .active:
            return "აქტიური"
        case .inactive:
            return "არააქტიური"
        }
    }
}

public class FinanceInfo: ObservableObject {
    public var totalPrice: Double
    public var totalGrants: Double
    public var paidAmount: Double
    public var debt: Double
    
    public init(totalPrice: Double,
                totalGrants: Double,
                paidAmount: Double,
                debt: Double) {
        self.totalPrice = totalPrice
        self.totalGrants = totalGrants
        self.paidAmount = paidAmount
        self.debt = debt
    }
}
