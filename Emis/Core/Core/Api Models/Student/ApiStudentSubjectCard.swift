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
    let studentId: Int
    let courseName: String
    let subjectCode: String
    let grade: String
    let markInSubject: Double
    let description: String
}
