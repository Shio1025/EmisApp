//
//  ApiStudentGrades.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//


struct ApiStudentGrade: Codable {
    var id: Int64
    var gradeComponentName: String
    var totalPoints: Double
    var currentPoints: Double
}
