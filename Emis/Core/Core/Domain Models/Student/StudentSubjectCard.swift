//
//  StudentSubjectCard.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct StudentSubjectCard {
    public init(subjectsBySemester: [[SubjectInfo]]) {
        self.subjectsBySemester = subjectsBySemester
    }
    
    let subjectsBySemester: [[SubjectInfo]]
    
    init(with model: [[ApiSubjectInfo]]) {
        self.subjectsBySemester = model.map { elems in
            elems.map { elem in
                SubjectInfo(with: elem)
            }
        }
    }
    
    public var reversedSubjectsList: [[SubjectInfo]] {
        Array(subjectsBySemester.reversed())
    }
}

public struct SubjectInfo {
    public init(studentId: Int64, courseName: String, courseId: Int64, subjectCode: String, grade: String, markInSubject: Double, description: String) {
        self.studentId = studentId
        self.courseId = courseId
        self.courseName = courseName
        self.subjectCode = subjectCode
        self.grade = grade
        self.markInSubject = markInSubject
    }
    
    public let studentId: Int64
    public let courseId: Int64
    public let courseName: String
    public let subjectCode: String
    public let grade: String?
    public let markInSubject: Double?
    
    init(with model: ApiSubjectInfo) {
        self.studentId = model.studentId
        self.courseId = model.courseId
        self.courseName = model.courseName
        self.subjectCode = model.subjectCode
        self.grade = model.grade
        self.markInSubject = model.mark
    }
}
