//
//  StudentFinancials.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct StudentFinancials {
    public let tuitionFee: Double
    public let tuitionFeePaid: Double
    public let scholarship: Double
    
    init(with model: ApiStudentFinancials) {
        self.tuitionFee = model.tuitionFee
        self.tuitionFeePaid = model.tuitionFeePaid
        self.scholarship = model.scholarship
    }
}
