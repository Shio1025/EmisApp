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
    
    init(with model: ApiStudentSubjectCard) {
        self.subjectsBySemester = model.subjectsBySemester.map { elems in
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
    public init(studentId: Int, courseName: String, subjectCode: String, grade: String, markInSubject: Double, description: String) {
        self.studentId = studentId
        self.courseName = courseName
        self.subjectCode = subjectCode
        self.grade = grade
        self.markInSubject = markInSubject
        self.description = description
    }
    
    public let studentId: Int
    public let courseName: String
    public let subjectCode: String
    public let grade: String
    public let markInSubject: Double
    public let description: String
    
    init(with model: ApiSubjectInfo) {
        self.studentId = model.studentId
        self.courseName = model.courseName
        self.subjectCode = model.subjectCode
        self.grade = model.grade
        self.markInSubject = model.markInSubject
        self.description = model.description
    }
}
