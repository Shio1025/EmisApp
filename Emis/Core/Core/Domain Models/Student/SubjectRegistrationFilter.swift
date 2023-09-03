//
//  SubjectRegistrationFilter.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

public struct SubjectRegistrationFilter {
    
    public init(content: [SubjectRegistrationModel],
                totalElements: Int,
                totalPages: Int) {
        self.content = content
        self.totalElements = totalElements
        self.totalPages = totalPages
    }
    
    public let content: [SubjectRegistrationModel]
    public let totalElements: Int
    public let totalPages: Int
    
    init(with model: ApiSubjectRegistrationFilter) {
        self.content = model.content.map { SubjectRegistrationModel(with: $0) }
        self.totalElements = model.totalElements
        self.totalPages = model.totalPages
    }
}

public struct SubjectRegistrationModel {
    public init(courseId: Int64, subjectCode: String, subjectName: String, available: Bool, prerequisites: [String]) {
        self.courseId = courseId
        self.subjectCode = subjectCode
        self.subjectName = subjectName
        self.available = available
        self.prerequisites = prerequisites
    }
    
    public let courseId: Int64
    public let subjectCode: String
    public let subjectName: String
    public let available: Bool
    let prerequisites: [String]
    
    init(with model: ApiSubjectRegistrationModel) {
        self.courseId = model.courseId
        self.subjectCode = model.subjectCode
        self.subjectName = model.subjectName
        self.available = model.available
        self.prerequisites = model.prerequisites
    }
    
    public var prerequisitesDesc: String {
        prerequisites.joined(separator: ", ")
    }
}
