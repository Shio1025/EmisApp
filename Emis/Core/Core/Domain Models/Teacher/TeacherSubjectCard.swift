//
//  TeacherSubjectCard.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

public struct TeacherSubjectCard {
    public init(courseId: Int64, subjectCode: String, subjectName: String) {
        self.courseId = courseId
        self.subjectCode = subjectCode
        self.subjectName = subjectName
    }
    
    public var courseId: Int64
    public var subjectCode: String
    public var subjectName: String
    
    init(with model: ApiTeacherSubjectCard) {
        self.courseId = model.courseId
        self.subjectCode = model.subjectCode
        self.subjectName = model.subjectName
    }
}
