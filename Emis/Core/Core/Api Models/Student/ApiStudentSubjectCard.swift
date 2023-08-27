//
//  ApiStudentSubjectCard.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

struct ApiStudentSubjectCard: Codable {
    let studentId: Int
    let subjectsBySemester: [[ApiSubjectInfo]]
}

struct ApiSubjectInfo: Codable {
    let id: Int
    let studentId: Int
    let subject: ApiSubject
    let semester: Int
    let grade: String
    let markInSubject: Double
}

struct ApiSubject: Codable {
    let id: Int
    let name: String
    let description: String
    let teachers: [String]
}
