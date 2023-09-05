//
//  RegisteredSubject.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

public struct RegisteredSubject {
    public init(courseId: Int64, subjectCode: String, subjectName: String, necessary: Bool) {
        self.courseId = courseId
        self.subjectCode = subjectCode
        self.subjectName = subjectName
        self.necessary = necessary
    }
    
    public let courseId: Int64
    public let subjectCode: String
    public let subjectName: String
    public let necessary: Bool
    
    init(with model: ApiRegisteredSubject) {
        self.courseId = model.courseId
        self.subjectCode = model.subjectCode
        self.subjectName = model.subjectName
        self.necessary = model.necessary ?? false
    }
}
