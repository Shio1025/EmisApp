//
//  StudentCourseInfo.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

public struct StudentCourseInfo {
    public init(course: Course, studentGradeInfo: [StudentGrade]) {
        self.course = course
        self.studentGradeInfo = studentGradeInfo
    }
    
    public var course: Course
    public var studentGradeInfo: [StudentGrade]
    
    init(with model: ApiStudentCourseInfo) {
        self.course = Course(with: model.course)
        self.studentGradeInfo = model.studentGradeInfo.map({ elem in
            StudentGrade(with: elem)
        })
    }
}
