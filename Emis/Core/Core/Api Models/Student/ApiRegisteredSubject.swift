//
//  ApiRegisteredSubject.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

struct ApiRegisteredSubject: Codable {
    let courseId: Int64
    let subjectCode: String
    let subjectName: String
    let necessary: Bool?
}
