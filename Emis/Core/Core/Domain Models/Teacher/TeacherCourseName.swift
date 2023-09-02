//
//  TeacherCourseName.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

public struct TeacherCourseInfo {
    public init(course: Course, students: [Student]) {
        self.course = course
        self.students = students
    }
    
    public var course: Course
    public var students: [Student]
    
    init(with model: ApiTeacherCourseInfo) {
        self.course = Course(with: model.course)
        self.students = model.students.map({ model in
            Student(with: model)
        })
    }
}

public struct Course {
    public init(id: Int64, subjectDescription: String, credits: Int, studentsLimit: Int, studentsRegistered: Int) {
        self.id = id
        self.subjectDescription = subjectDescription
        self.credits = credits
        self.studentsLimit = studentsLimit
        self.studentsRegistered = studentsRegistered
    }
    
    public var id: Int64
    public var subjectDescription: String
    public var credits: Int
    public var studentsLimit: Int
    public var studentsRegistered: Int
    
    init(with model: ApiCourse) {
        self.id = model.id
        self.subjectDescription = model.subjectDescription
        self.credits = model.credits
        self.studentsLimit = model.studentsLimit
        self.studentsRegistered = model.studentsRegistered
    }
}

public struct Student {
    public init(id: Int64, firstName: String, lastName: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    public var id: Int64
    public var firstName: String
    public var lastName: String
    public var email: String
    
    init(with model: ApiStudent) {
        self.id = model.id
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.email = model.email
    }
}
