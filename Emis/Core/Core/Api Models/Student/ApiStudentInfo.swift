//
//  ApiStudentInfo.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

struct ApiStudentInfo: Codable {
    let firstName: String
    let lastName: String
    let birthDate: String
    let email: String
    let address: String
    let phoneNumber: String
    let status: String
    let degreeLevel: String
    let credits: Int
    let gpa: Double
}
