//
//  ApiStudentCourseInfo.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

struct ApiStudentCourseInfo: Codable {
    var course: ApiCourse
    var studentGradeInfo: [ApiStudentGrade]
}
