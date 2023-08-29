//
//  ApiStudentFinancials.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

struct ApiStudentFinancials: Codable {
    let tuitionFee: Double
    let scholarship: Double
    let effectiveFee: Double
    let tuitionFeePaid: Double
    let debt: Double
}
