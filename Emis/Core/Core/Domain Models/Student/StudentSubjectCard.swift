//
//  StudentSubjectCard.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct StudentSubjectCard {
    public let subjectsBySemester: [[SubjectInfo]]
    
    init(with model: ApiStudentSubjectCard) {
        self.subjectsBySemester = model.subjectsBySemester.map { elems in
            elems.map { elem in
                SubjectInfo(with: elem)
            }
        }
    }
}

public struct SubjectInfo {
    public let subject: Subject
    public let semester: Int
    public let grade: String
    public let markInSubject: Double
    
    init(with model: ApiSubjectInfo) {
        self.subject = Subject(with: model.subject)
        self.semester = model.semester
        self.grade = model.grade
        self.markInSubject = model.markInSubject
    }
}

public struct Subject {
    let name: String
    let description: String
    let teachers: [String]
    
    init(with model: ApiSubject) {
        self.name = model.name
        self.description = model.description
        self.teachers = model.teachers
    }
}
