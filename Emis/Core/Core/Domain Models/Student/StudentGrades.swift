//
//  StudentGrades.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

public struct StudentGrade {
    public init(id: Int64, gradeComponentName: String, totalPoints: Double, currentPoints: Double) {
        self.id = id
        self.gradeComponentName = gradeComponentName
        self.totalPoints = totalPoints
        self.currentPoints = currentPoints
    }
    
    public var id: Int64
    public var gradeComponentName: String
    public var totalPoints: Double
    public var currentPoints: Double
    
    init(with model: ApiStudentGrade) {
        self.id = model.id
        self.gradeComponentName = model.gradeComponentName
        self.totalPoints = model.totalPoints
        self.currentPoints = model.currentPoints
    }
}

