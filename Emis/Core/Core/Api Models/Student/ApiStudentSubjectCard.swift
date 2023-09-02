//
//  ApiStudentSubjectCard.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

struct ApiSubjectInfo: Codable {
    let studentId: Int64
    let courseId: Int64
    let courseName: String
    let subjectCode: String
    let grade: String
    let mark: Double
    let description: String
}
