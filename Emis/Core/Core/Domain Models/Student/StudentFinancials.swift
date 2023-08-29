//
//  StudentFinancials.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct StudentFinancials {
    public init(tuitionFee: Double, scholarship: Double, effectiveFee: Double, tuitionFeePaid: Double, debt: Double) {
        self.tuitionFee = tuitionFee
        self.scholarship = scholarship
        self.effectiveFee = effectiveFee
        self.tuitionFeePaid = tuitionFeePaid
        self.debt = debt
    }
    
    public let tuitionFee: Double
    public let scholarship: Double
    public let effectiveFee: Double
    public let tuitionFeePaid: Double
    public let debt: Double
    
    init(with model: ApiStudentFinancials) {
        self.tuitionFee = model.tuitionFee
        self.tuitionFeePaid = model.tuitionFeePaid
        self.scholarship = model.scholarship
        self.effectiveFee = model.effectiveFee
        self.debt = model.debt
    }
}
