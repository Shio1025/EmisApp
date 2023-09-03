//
//  ApiSubjectRegistrationFilter.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

struct ApiSubjectRegistrationFilter: Codable {
    let content: [ApiSubjectRegistrationModel]
    let totalElements: Int
    let totalPages: Int
}

struct ApiSubjectRegistrationModel: Codable {
    let courseId: Int64
    let subjectCode: String
    let subjectName: String
    let available: Bool
    let prerequisites: [String]
}
