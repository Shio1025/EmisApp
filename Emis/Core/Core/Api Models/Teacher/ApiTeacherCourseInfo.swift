//
//  ApiTeacherCourseInfo.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

struct ApiTeacherCourseInfo: Codable {
    var course: ApiCourse
    var students: [ApiStudent]
}

struct ApiCourse: Codable {
    var id: Int64
    var subjectDescription: String
    var credits: Int
    var studentsLimit: Int
    var studentsRegistered: Int
}

struct ApiStudent: Codable {
    var id: Int64
    var firstName: String
    var lastName: String
    var email: String
}
